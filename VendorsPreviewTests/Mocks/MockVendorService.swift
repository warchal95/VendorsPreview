//
//  MockVendorService.swift
//  VendorsPreviewTests
//
//  Created by Michał Warchał on 08/04/2022.
//

import Foundation
@testable import VendorsPreview

class MockVendorService: VendorService {
    var result: Result<[Vendor], Error> = .success([])
    var shouldCallCompletion = true
    
    func get(completion: @escaping (Result<[Vendor], Error>) -> Void) {
        guard shouldCallCompletion else { return }
        completion(result)
    }
}
