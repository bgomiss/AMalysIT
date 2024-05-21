//
//  URLImageViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import Foundation

class URLImageViewModel: ObservableObject {
    let urlImage: URLImage? = nil
    
    func fetchData(at index: Int, urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if index < self.urlImage?.data.count ?? 0 {
                    self.urlImage?.data[index] = data
                }
            }
        }
        task.resume()
    }
}
