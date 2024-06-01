//
//  ProductViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var analysis: ProductModel?
    @Published var productDetails: [ProductDetails]?
    
    enum EndPoint {
        case productSearch
        case imageGraph
        var url: String {
            switch self {
            case .productSearch:
                return "https://api.keepa.com/search?key=\(API.apiKey)&domain=2&type=product&term=lotion&page=0"
            case .imageGraph:
                return "https://api.keepa.com/search?key=\(API.apiKey)&domain=2&type=product&term=lotion&page=1"
            }
        }
    }
    
    func fetch(for endpoint: EndPoint) {
        guard let url = URL(string: endpoint.url) else  { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else { return }
        
            // Convert to JSON
            do {
                switch endpoint {
                case .productSearch:
                    let product = try JSONDecoder().decode(ProductModel.self, from: data)
                    DispatchQueue.main.async {
                        self?.analysis = product
                        self?.productDetails = product.products
                    }
                case .imageGraph:
                    let product = try JSONDecoder().decode(ProductModel.self, from: data)
                    DispatchQueue.main.async {
                        self?.analysis = product
                        self?.productDetails = product.products
                    }
                    
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
