//
//  CartCellController.swift
//  Test-POS
//
//  Created by Abu Hamdan on 6/20/21.
//

import Foundation
import GenericCellControllers
import SDWebImage

class CartCellController: GenericCellController<CartCell> {
    
    private let product: Product
    

    init(product: Product) {
        self.product = product
    }

    override func configureCell(_ cell: CartCell) {

        cell.lblBrandName.text = product.manufacturer_name
        cell.lblProductName.text = product.name
        cell.lblProductName.numberOfLines = 0
        cell.lblPrice.text = product.price
        cell.lblCount.text = product.quantity

        if let imageUrl = product.product_image {
            let thumbnailSize = CGSize(width: 135, height: 135)
            if  let urlWithPercent = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                let url = URL(string: urlWithPercent)
                guard let productImageUrl = url  else {
                    return
                }
                cell.productImageVw.sd_setImage(with: productImageUrl, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
                cell.productImageVw.contentMode = .scaleAspectFit
            }
        }
    }

    override func didSelectCell() {
        //coordinator.pictureSelected(picture)
    }
}
