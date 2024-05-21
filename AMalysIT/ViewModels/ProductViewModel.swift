//
//  ProductViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var analysis: ProductModel?
    @Published var productDetails: ProductDetails?
    
    func fetch() {
        guard let url = URL(string: "https://api.keepa.com/search?key=\(API.apiKey)&domain=2&type=product&term=lotion&page=0") else  { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else { return }
            
            // Convert to JSON
            do {
                let product = try JSONDecoder().decode(ProductModel.self, from: data)
                DispatchQueue.main.async {
                    self?.analysis = product
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
