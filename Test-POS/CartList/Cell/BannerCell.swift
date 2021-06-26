//
//  BannerCell.swift
//  Test-POS
//
//  Created by Abu Hamdan on 6/21/21.
//

import UIKit
import SnapKit

class BannerCell: UITableViewCell {
    static let identifier = "BannerCell"
    
    lazy var bannerImageVw: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 10
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubiews()
        setupConstraints()
        self.semanticContentAttribute = .forceRightToLeft
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubiews() {
        
        let bannerContainersubviews = [bannerImageVw]
        bannerContainersubviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        
        bannerImageVw.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(8)
        }
    }
}
