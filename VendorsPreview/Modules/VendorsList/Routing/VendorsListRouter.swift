//
//  VendorsListRouter.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import UIKit

protocol VendorsListRouter {
    func routeToVendorDetails(viewModel: VendorDetailsViewModel)
    func showError(_ error: Error)
}

class VendorsListDefaultRouter {

    private weak var viewController: UIViewController?
    
    func addViewController(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension VendorsListDefaultRouter: VendorsListRouter {
    func routeToVendorDetails(viewModel: VendorDetailsViewModel) {
        let detailsViewController = VendorDetailsViewController.build(viewModel: viewModel)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func showError(_ error: Error) {
        let alertViewController = UIAlertController(title: NSLocalizedString("error_alert_title", comment: "Something Went Wrong Alert Title"),
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: NSLocalizedString("error_alert_button_title", comment: "Cancel alert button"),
                                                    style: .cancel,
                                                    handler: nil))
        viewController?.present(alertViewController, animated: true)
    }
}
