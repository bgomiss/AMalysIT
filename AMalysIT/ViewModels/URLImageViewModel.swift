//
//  URLImageViewModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import Foundation
import SwiftUI

class URLImageViewModel: ObservableObject {
    @Published var data: [Data?] = []
    
    init(urlStrings: [String]) {
        self.data = Array(repeating: nil, count: urlStrings.count)
        fetchData(for: urlStrings)
    }
    
    private func fetchData(for urlStrings: [String]) {
        for (index, urlString) in urlStrings.enumerated() {
            guard let url = URL(string: urlString) else { continue }
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                DispatchQueue.main.async {
                    if index < self?.data.count ?? 0 {
                        self?.data[index] = data
                    }
                }
            }
            task.resume()
        }
    }
}

