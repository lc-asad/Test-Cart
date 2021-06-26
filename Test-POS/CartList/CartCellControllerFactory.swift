//
//  CartCellControllerFactory.swift
//  Test-POS
//
//  Created by Abu Hamdan on 6/20/21.
//

import Foundation
import GenericCellControllers

class CartCellControllerFactory {
    
    func registerCells(on tableView: UITableView) {
        
        CartCellController.registerCell(on: tableView)
        BannerCellController.registerCell(on: tableView)
    }
    
    func cellControllers(from elements: [CartElement]) -> [TableCellController] {
        
        return elements.map { (element) in
            switch element {
            case .banner(let banner):
                return BannerCellController(banner: banner)
            case .product(let product):
                return CartCellController(product:product)
            }
        }
    }
}
