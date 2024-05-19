//
//  ViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import Foundation

class SellerViewModel: ObservableObject {
    @Published var analysis: SellerModel?
    
    func fetch() {
        guard let url = URL(string: "https://api.keepa.com/seller?key=\(Api.apiKey)&domain=1&type=product&seller=A2QE71HEBJRNZE") else  { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else { return }
            
            // Convert to JSON
            do {
                let model = try JSONDecoder().decode(SellerModel.self, from: data)
                DispatchQueue.main.async {
                    self?.analysis = model
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
