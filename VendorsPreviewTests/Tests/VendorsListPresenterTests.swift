//
//  VendorsListPresenterTests.swift
//  VendorsPreviewTests
//
//  Created by Michał Warchał on 08/04/2022.
//

import XCTest
@testable import VendorsPreview

class VendorsListPresenterTests: XCTestCase {
    
    var sut: VendorsListDefaultPresenter!
    
    var router: MockVendorsListRouter!
    var vendorService: MockVendorService!
    var interactor: VendorsListInteractor!
    var viewInterface: MockVendorsListViewInterface!
    
    override func setUp() {
        super.setUp()
        router = MockVendorsListRouter()
        vendorService = MockVendorService()
        interactor = VendorsListDefaultInteractor(vendorService: vendorService)
        viewInterface = MockVendorsListViewInterface()
        sut = VendorsListDefaultPresenter(interactor: interactor, router: router, queue: MockQueue())
    }

    override func tearDown() {
        router = nil
        vendorService = nil
        interactor = nil
        viewInterface = nil
        sut = nil
        super.tearDown()
    }
    
    func testCellViewModelsIsEmptyWithoutFetchingData() {
        XCTAssertTrue(sut.cellViewModels.isEmpty)
    }
    
    func testCellViewModelsFilledAfterSuccessfulRequest() {
        let items: [Vendor] = [
            Vendor(id: 0, name: "name", heroImage: Vendor.HeroImage(url: "https://www.google.com"), description: "description", openingHours: nil),
            Vendor(id: 1, name: "name", heroImage: Vendor.HeroImage(url: "https://www.google.com"), description: "description", openingHours: nil)
        ]
        vendorService.result = .success(items)
        
        sut.viewDidLoad()
        
        XCTAssertEqual(sut.cellViewModels.count, items.count)
        XCTAssertEqual(sut.cellViewModels[0].id, items[0].id)
        XCTAssertEqual(sut.cellViewModels[0].name, items[0].name)
    }
    
    func testViewUpdatedAfterSuccessfulRequest() {
        sut.attach(view: viewInterface)
        sut.viewDidLoad()
        
        XCTAssertTrue(viewInterface.wasUpdateDataSourceCalled)
    }
    
    func testIfActivityIndicatorIsAnimatingDuringRequest() {
        sut.attach(view: viewInterface)
        vendorService.shouldCallCompletion = false
        
        sut.viewDidLoad()
        XCTAssertTrue(viewInterface.isActivityIndicatorAnimating)
    }
    
    func testShowAlertIsCalledOnError() {
        vendorService.result = .failure(NetworkError.general)
        
        sut.viewDidLoad()
        XCTAssertNotNil(router.errorToShow)
    }
    
    func testSelectingRowCallsRouterShowDetails() {
        let items: [Vendor] = [Vendor(id: 0, name: "name", heroImage: Vendor.HeroImage(url: "https://www.google.com"), description: "description", openingHours: nil)]
        vendorService.result = .success(items)
        sut.viewDidLoad()

        sut.didSelectRow(at: 0)
        
        XCTAssertNotNil(router.viewModelToShow)
        XCTAssertTrue(router.wasRouteToVendorDetailsCalled)
    }
}
