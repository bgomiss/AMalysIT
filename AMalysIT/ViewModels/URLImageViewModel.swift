//
//  URLImageViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import Foundation

class URLImageViewModel: ObservableObject {
    let urlImage: URLImage? = nil
    
    func fetchData() {
        guard let url = URL(string: urlImage?.urlString ?? "") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.urlImage?.data = data
        }
        task.resume()
    }
}
