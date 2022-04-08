//
//  VendorsListInteractor.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

protocol VendorsListInteractor {
    func getVendors(completion: @escaping  (Result<[Vendor], Error>) -> Void)
}

class VendorsListDefaultInteractor: VendorsListInteractor {
    
    private let vendorService: VendorService
    
    init(vendorService: VendorService = NetworkBasedVendorService()) {
        self.vendorService = vendorService
    }
    
    func getVendors(completion: @escaping  (Result<[Vendor], Error>) -> Void) {
        vendorService.get(completion: completion)
    }
}
