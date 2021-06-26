//
//  CartListView.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/19/21.
//

import UIKit
import SnapKit

class CartListView: UIView {

    lazy var tableList = UITableView(frame: .zero)
    lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    init() {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(hexString: "f6f6f6")
        addSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        
        let subviews = [tableList, activityIndicationView]
        subviews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func startLoading() {
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        
        activityIndicationView.stopAnimating()
    }
    
    private func setUpConstraints() {
        tableList.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
        }
        
        activityIndicationView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 50, height: 50.0))
        }

    }

}
