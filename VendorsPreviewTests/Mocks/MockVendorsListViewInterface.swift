//
//  MockVendorsListViewInterface.swift
//  VendorsPreviewTests
//
//  Created by Michał Warchał on 08/04/2022.
//

import Foundation
@testable import VendorsPreview

class MockVendorsListViewInterface: VendorsListViewInterface {
    var isActivityIndicatorAnimating: Bool = false
    
    var wasUpdateDataSourceCalled = false
    func updateDataSource() {
        wasUpdateDataSourceCalled = true
    }
}
