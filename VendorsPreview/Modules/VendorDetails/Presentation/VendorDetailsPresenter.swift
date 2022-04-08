//
//  VendorDetailsPresenter.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

protocol VendorDetailsPresenter {
    func viewDidLoad()
}

class VendorDetailsDefaultPresenter {

    private let viewModel: VendorDetailsViewModel

    private weak var view: VendorDetailsViewInterface?

    init(viewModel: VendorDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    func attach(view: VendorDetailsViewInterface) {
        self.view = view
    }
}

extension VendorDetailsDefaultPresenter: VendorDetailsPresenter {
    func viewDidLoad() {
        view?.updateView(with: viewModel)
    }
}
