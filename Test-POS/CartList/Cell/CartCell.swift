//
//  CartCell.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/20/21.
//

import UIKit
import SnapKit


class CartCell: UITableViewCell {
    static let identifier = "CartCell"
    
    lazy var productImageVw = UIImageView()
    lazy var lblProductName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "DINNextLTW23-Regular", size: 16.0)
        return label
    }()

    lazy var lblPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "DINNextLTW23-Medium", size: 16.0)
        return label
    }()
    
    lazy var lblBrandName: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.init(red: 32/255, green: 32/255, blue: 32/255, alpha: 0.38)
        label.font = UIFont.init(name: "DINNextLTW23-Regular", size: 16.0)
        return label
    }()
    lazy var lblCount = UILabel()
    lazy var btnDelete:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "trash"), for: .normal)
        return button
    }()
    
    lazy var btnContainerView:UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 3
        return view
    }()
    
    lazy var btnPlus:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    lazy var btnMinus:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "minus"), for: .normal)
        return button
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
        
        let btnContainersubviews = [btnPlus,lblCount,btnMinus]
        btnContainersubviews.forEach {
            btnContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let subviews = [productImageVw,lblBrandName,lblProductName,lblPrice, btnContainerView, btnDelete]
        subviews.forEach {
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        
        productImageVw.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(contentView).offset(16)
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.top.equalToSuperview().offset(25)
        }
        
        lblBrandName.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(112)
        }
        
        lblProductName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblBrandName).offset(25)
            make.left.equalToSuperview().offset(112)
            make.right.equalToSuperview().offset(-26)
        }
        
        lblPrice.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(lblProductName).offset(50)
            make.left.equalToSuperview().offset(112)
        }
        
        btnDelete.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-16)
            make.size.equalTo(CGSize(width: 20.0, height: 24.0))
            make.top.equalTo(contentView).offset(16)
        }
        
        btnContainerView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(contentView).offset(-16)
            make.bottom.equalTo(contentView).offset(-8)
            make.size.equalTo(CGSize(width: 80, height: 25))
            
        }
        
        lblCount.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(btnContainerView)
            make.centerX.equalTo(btnContainerView)
        }
        
        btnMinus.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(btnContainerView).offset(8)
            make.centerY.equalTo(btnContainerView)
        }
        
        btnPlus.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(btnContainerView).offset(-8)
            make.centerY.equalTo(btnContainerView)
        }
    }
}
