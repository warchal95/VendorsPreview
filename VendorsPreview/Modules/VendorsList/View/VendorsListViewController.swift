//
//  VendorsListViewController.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import UIKit

protocol VendorsListViewInterface: AnyObject {
    var isActivityIndicatorAnimating: Bool { get set }
    func updateDataSource()
}

class VendorsListViewController: UIViewController {
    
    var isActivityIndicatorAnimating: Bool {
        get { vendorsListView.activityIndicatorView.isAnimating }
        set { newValue ? vendorsListView.activityIndicatorView.startAnimating() : vendorsListView.activityIndicatorView.stopAnimating() }
    }
    
    private let presenter: VendorsListPresenter

    private lazy var vendorsListView: VendorsListView = {
        let view = VendorsListView(frame: .zero)
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.register(VendorTableViewCell.self, forCellReuseIdentifier: VendorTableViewCell.identifier)
        return view
    }()
    
    init(presenter: VendorsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = vendorsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension VendorsListViewController: VendorsListViewInterface {
    func updateDataSource() {
        vendorsListView.tableView.reloadData()
    }
}

extension VendorsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VendorTableViewCell.identifier, for: indexPath) as? VendorTableViewCell else {
            return UITableViewCell()
        }
        let viewModel = presenter.cellViewModels[indexPath.row]
        cell.setup(with: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension VendorsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
}

extension VendorsListViewController {
    static func build() -> VendorsListViewController {
        let interactor = VendorsListDefaultInteractor()
        let router = VendorsListDefaultRouter()
        let presenter = VendorsListDefaultPresenter(interactor: interactor,
                                                    router: router)
        let viewController = VendorsListViewController(presenter: presenter)
        
        presenter.attach(view: viewController)
        router.addViewController(viewController)

        return viewController
    }
}
