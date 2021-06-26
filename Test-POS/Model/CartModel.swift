//
//  CartModel.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/20/21.
//

import Foundation

enum CartElement {
    case product(Product)
    case banner(AddBanner)
}

struct CartResponse: Codable {
    let data: CartData
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct CartData: Equatable, Hashable, Codable {
    let products: [Product]
    let addBanner: AddBanner
    
    enum CodingKeys: String, CodingKey {
        case products
        case addBanner = "Ad"
    }
}
struct Product: Equatable, Hashable,Codable {
    let name: String
    let manufacturer_name: String
    let product_image: String?
    let price: String
    let quantity: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case manufacturer_name
        case product_image = "thumb"
        case price = "price_formatted"
        case quantity
    }
    
}

struct AddBanner: Codable,Equatable, Hashable {
    let image_url: String
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        case image_url
        case width
        case height
    }
}
