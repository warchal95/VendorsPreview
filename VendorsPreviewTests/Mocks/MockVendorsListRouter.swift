//
//  MockVendorsListRouter.swift
//  VendorsPreviewTests
//
//  Created by Michał Warchał on 08/04/2022.
//

import Foundation
@testable import VendorsPreview

class MockVendorsListRouter: VendorsListRouter {
    
    private(set) var viewModelToShow: VendorDetailsViewModel?
    var wasRouteToVendorDetailsCalled = false
    func routeToVendorDetails(viewModel: VendorDetailsViewModel) {
        viewModelToShow = viewModel
        wasRouteToVendorDetailsCalled = true
    }
    
    private(set) var errorToShow: Error?
    func showError(_ error: Error) {
        errorToShow = error
    }
}
