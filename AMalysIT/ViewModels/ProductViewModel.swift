//
//  ProductViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var analysis: ProductModel?
    @Published var singleProductAnalysis: [String:ProductDetails] = [:]
    @Published var productDetails: [ProductDetails]?
    @Published var graphImageUrlStrings: [String:String] = [:]

    
    enum EndPoint {
        case productSearch(String)
        case imageGraph(GraphImageParameters)
        case singleProductDetails(GraphImageParameters)
        var url: String {
            switch self {
            case .productSearch(let query):
                return "https://api.keepa.com/search?key=\(API.apiKey)&domain=2&type=product&term=\(query)&page=0"
            case .imageGraph(let parameters):
                return "https://api.keepa.com/graphimage?key=\(API.apiKey)&domain=2&asin=\(parameters.asin)&fba=1&bb=1"
            case .singleProductDetails(let asin):
                return "https://api.keepa.com/product?key=\(API.apiKey)&domain=2&asin=\(asin.asin)&buybox=1&stats=1&&offers=4"
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
                case .imageGraph(let parameters):
                    DispatchQueue.main.async {
                        if let imageUrlString = self?.saveImageToTemporaryDirectory(data: data) {
                            self?.graphImageUrlStrings[parameters.asin] = imageUrlString
                        }
                    }
                case .singleProductDetails(let asin):
                    let singleProduct = try JSONDecoder().decode(ProductModel.self, from: data)
                    if let productDetail = singleProduct.products.first {
                        DispatchQueue.main.async {
                            self?.singleProductAnalysis[asin.asin] = productDetail
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    private func saveImageToTemporaryDirectory(data: Data) -> String? {
            let temporaryDirectory = FileManager.default.temporaryDirectory
            let fileName = UUID().uuidString + ".png"
            let fileURL = temporaryDirectory.appendingPathComponent(fileName)

            do {
                try data.write(to: fileURL)
                return fileURL.absoluteString
            } catch {
                print("Error saving image to temporary directory: \(error)")
                return nil
            }
        }
}
