//
//  CartService.swift
//  Test-POS
//
//  Created by Asad Ullah on 6/20/21.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol CartServiceProtocol {
    func get() -> AnyPublisher<CartData, Error>
}

final class CartService: CartServiceProtocol {
    
    func get() -> AnyPublisher<CartData, Error> {
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }
        
        return Future<CartData, Error> { [weak self] promise in
            guard let urlRequest = self?.getUrlRequest() else {
                promise(.failure(ServiceError.urlRequest))
                return
            }
            
            dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                guard let data = data else {
                    if let error = error {
                        promise(.failure(error))
                    }
                    return
                }
                do {
                    
                    let cartResponse = try JSONDecoder().decode(CartResponse.self, from: data)
                    promise(.success(cartResponse.data))
                } catch  let error {
                    print("Error in reponse:", error)
                    promise(.failure(ServiceError.decode))
                }
            }
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func getUrlRequest() -> URLRequest? {
        
        let urlString = "https://test.niceonesa.com?route=rest/cart/cart"
        let url = URL(string: urlString)!
        print("Final URL: ",url)
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 30.0
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "X-Oc-Merchant-Id" : "2afc3973-04a5-4913-83f8-d45b0156b5f1",
            "X-Oc-Merchant-Language" : "ar",
            "X-Oc-Currency" : "SAR",
            "versionnumber" : "3.5.6",
            "X-Oc-Session" : "2b12982b56295dec3836ef04e4d69621",
            "Content-Type" : "application/json",
            "platform" : "ios"
        ]
        return urlRequest
    }
}
