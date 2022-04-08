//
//  VendorsListPresenter.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

protocol VendorsListPresenter {
    var cellViewModels: [VendorCellViewModel] { get }
    func didSelectRow(at index: Int)
    func viewDidLoad()
}

class VendorsListDefaultPresenter {

    var cellViewModels: [VendorCellViewModel] = []

    private let interactor: VendorsListInteractor
    private let router: VendorsListRouter
    private let queue: Dispatching
    private let openingHoursResolver: OpeningHoursTextResolver
    
    private weak var view: VendorsListViewInterface?
    
    private var vendors: [Vendor] = []
    
    init(interactor: VendorsListInteractor,
         router: VendorsListRouter,
         queue: Dispatching = DispatchQueue.main,
         openingHoursResolver: OpeningHoursTextResolver = OpeningHoursTextResolver()) {
        self.interactor = interactor
        self.router = router
        self.queue = queue
        self.openingHoursResolver = openingHoursResolver
    }
    
    func attach(view: VendorsListViewInterface) {
        self.view = view
    }
    
    private func fetchVendors() {
        interactor.getVendors { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let vendors):
                self.cellViewModels = vendors.map {
                    VendorCellViewModel(id: $0.id,
                                        name: $0.name,
                                        openingHoursRangeText: self.openingHoursResolver.resolve(openingHours: $0.openingHours),
                                        imageUrl: URL(string: $0.heroImage.url))
                }
                self.vendors = vendors
                
                self.queue.async(execute: DispatchWorkItem(block: {
                    self.view?.isActivityIndicatorAnimating = false
                    self.view?.updateDataSource()
                }))
            case .failure(let error):
                self.queue.async(execute: DispatchWorkItem(block: {
                    self.view?.isActivityIndicatorAnimating = false
                    self.router.showError(error)
                }))
            }
        }
    }
}

extension VendorsListDefaultPresenter: VendorsListPresenter {
    func viewDidLoad() {
        view?.isActivityIndicatorAnimating = true
        fetchVendors()
    }

    func didSelectRow(at index: Int) {
        let identifier = cellViewModels[index].id
        guard let vendor = vendors.first(where: { $0.id == identifier }) else {
            return
        }
        router.routeToVendorDetails(viewModel: VendorDetailsViewModel(name: vendor.name,
                                                                      imageUrl: URL(string: vendor.heroImage.url),
                                                                      description: vendor.description))
    }
}
