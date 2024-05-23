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
                        let imageUrls = productDetails.imageUrls
                        URLImage(urlStrings: imageUrls)
                            .frame(height: 120)
                        
                        Text(productDetails.brand)
                        Text(productDetails.title)
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
