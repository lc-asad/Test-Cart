//
//  CartListViewController.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/19/21.
//

import UIKit
import Combine
import GenericCellControllers

class CartListViewController: UIViewController {
    
    private let cellControllerFactory = CartCellControllerFactory()
    private var cellControllers: [TableCellController] = []
    
    private lazy var contentView = CartListView()
    private let viewModel: CartListViewModel
    private var bindings = Set<AnyCancellable>()
    var products = [Product]()
    
    init(viewModel: CartListViewModel = CartListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "سلة التسوق"
        
        setUpTableView()
        setUpBindings()
    }
    
    private func setUpTableView() {
        
        cellControllerFactory.registerCells(on: contentView.tableList)
        contentView.tableList.dataSource = self
        contentView.tableList.rowHeight = 150
        contentView.tableList.semanticContentAttribute = .forceRightToLeft
        contentView.tableList.tableFooterView = UIView.init(frame: .zero)
        view.semanticContentAttribute = .forceRightToLeft
    }
    
    private func setUpBindings() {
        
        func bindViewModelToView() {
            viewModel.$cart
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] cart  in
                    guard let cart = cart else{
                        return
                    }
                    self?.loadCart(products: cart.products, banner: cart.addBanner)
                })
                .store(in: &bindings)
            
            let stateValueHandler: (ListViewModelState) -> Void = { [weak self] state in
                switch state {
                case .loading:
                    self?.contentView.startLoading()
                case .finishedLoading:
                    self?.contentView.finishLoading()
                case .error(let error):
                    self?.contentView.finishLoading()
                    self?.showError(error)
                }
            }
            
            viewModel.$state
                .receive(on: RunLoop.main)
                .sink(receiveValue: stateValueHandler)
                .store(in: &bindings)
        }
        
        bindViewModelToView()
    }
    
    private func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func loadCart(products: [Product], banner: AddBanner) {
        self.products = products
        var data: [CartElement] = [CartElement]()
        data.append(.banner(banner))
        
        for product in products {
            data.append(.product(product))
        }
        cellControllers = cellControllerFactory.cellControllers(from: data)
        contentView.tableList.dataSource = self
        contentView.tableList.reloadData()

    }
}

extension CartListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        return cellControllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
    }
}
