//
//  ProductView.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import SwiftUI

    struct ProductView: View {
        
        @StateObject var viewModel = ProductViewModel()
        
        
        var body: some View {
            NavigationStack {
                List {
                    if let productDetails = viewModel.productDetails, !productDetails.imagesCSV.isEmpty {
                        let imageUrls = productDetails.imagesCSV.split(separator: ",").map { "https://images-na.ssl-images-amazon.com/images/I/\($0.trimmingCharacters(in: .whitespaces))" }
                        URLImage(urlStrings: imageUrls)
                            .frame(height: 120)
                    } else {
                        Text("Loading products...")
                    }
                }
                .navigationTitle("AMAZON")
                .onAppear {
                    viewModel.fetch()
                }
            }
        }
    }

#Preview {
    ProductView()
}
