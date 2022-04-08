//
//  VendorDetailsViewController.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import UIKit

protocol VendorDetailsViewInterface: AnyObject {
    func updateView(with model: VendorDetailsViewModel)
}

class VendorDetailsViewController: UIViewController {
    
    private let presenter: VendorDetailsPresenter

    private lazy var vendorDetailsView = VendorDetailsView(frame: .zero)
    
    init(presenter: VendorDetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = vendorDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension VendorDetailsViewController: VendorDetailsViewInterface {
    func updateView(with model: VendorDetailsViewModel) {
        vendorDetailsView.setup(with: model)
    }
}

extension VendorDetailsViewController {
    static func build(viewModel: VendorDetailsViewModel) -> VendorDetailsViewController {
        let presenter = VendorDetailsDefaultPresenter(viewModel: viewModel)
        let viewController = VendorDetailsViewController(presenter: presenter)
        
        presenter.attach(view: viewController)

        return viewController
    }
}
