//
//  VendorService.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

protocol VendorService {
    func get(completion: @escaping (Result<[Vendor], Error>) -> Void)
}

class NetworkBasedVendorService: VendorService {
    
    func get(completion: @escaping (Result<[Vendor], Error>) -> Void) {
        guard let urlComponents = URLComponents(string: "https://nobu.cms.alliants.app/vendors") else {
            completion(.failure(NetworkError.requestMalformed))
            return
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.requestMalformed))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200 ..< 300 ~= response.statusCode,
                error == nil
            else {
                completion(.failure(error ?? NetworkError.general))
                return
            }
            
            do {
                let vendors = try JSONDecoder().decode([Vendor].self, from: data)
                completion(.success(vendors))
            } catch {
                completion(.failure(NetworkError.parsing))
            }
        }
        task.resume()
    }
}
