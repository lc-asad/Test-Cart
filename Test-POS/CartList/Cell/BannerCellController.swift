//
//  BannerCellController.swift
//  Test-POS
//
//  Created by Abu Hamdan on 6/22/21.
//

import Foundation
import GenericCellControllers
import SDWebImage

class BannerCellController: GenericCellController<BannerCell> {
    
    private let banner: AddBanner
    
    
    init(banner: AddBanner) {
        self.banner = banner
    }
    
    override func configureCell(_ cell: BannerCell) {
        
        let imageUrl = banner.image_url
        let thumbnailSize = CGSize(width: banner.width, height: banner.height)
        //if  let urlWithPercent = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: imageUrl)
            guard let productImageUrl = url  else {
                return
            }
            cell.bannerImageVw.sd_setImage(with: productImageUrl, placeholderImage: nil, context: [.imageThumbnailPixelSize : thumbnailSize])
        //}
        
    }
    
    override func didSelectCell() {
        //TODO: -
    }
}


