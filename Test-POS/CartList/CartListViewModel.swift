//
//  CartListViewModel.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/20/21.
//

import Foundation
import Combine

enum ListViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}

class CartListViewModel {
    
    @Published private(set) var cart: CartData?
    @Published private(set) var state: ListViewModelState = .loading
    
    private let cartService: CartServiceProtocol
    private var bindings = Set<AnyCancellable>()
    
    
    init(cartService: CartServiceProtocol = CartService()) {
        self.cartService = cartService
        fetchProducts()
    }
    
    func fetchProducts() {
        state = .loading
        
        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error): self?.state = .error(error)
            case .finished: self?.state = .finishedLoading
            }
        }
        
        let cartValueHandler: (CartData) -> Void = { [weak self] cartData in
            self?.cart = cartData
        }
        cartService
            .get()
            .sink(receiveCompletion: completionHandler, receiveValue: cartValueHandler)
            .store(in: &bindings)
    }
}
