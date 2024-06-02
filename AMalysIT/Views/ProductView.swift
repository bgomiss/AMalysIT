//
//  ProductView.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    @State var parameters: GraphImageParameters? = nil
    
    var body: some View {
        NavigationStack {
            List {
                productDetailsSection
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    CustomNavigationBarTitle()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetch(for: .productSearch)
                }
            .onChange(of: viewModel.productDetails ?? [], initial: true) { _ ,newProductDetails in
                    fetchImages(for: newProductDetails)
                }
            }
        }
    
    private var productDetailsSection: some View {
        Group {
            if let productDetailsArray = viewModel.productDetails {
                ForEach(productDetailsArray, id: \.self) { productDetails in
                    VStack {
                        if !productDetails.imagesCSV.isEmpty {
                            let imageUrls = productDetails.imageUrls
                            URLImage(urlStrings: imageUrls)
                                .frame(height: 120)
                            Text(productDetails.brand)
                            Text(productDetails.title)
                            
                        }
                        if let graphImageUrlStrings = viewModel.graphImageUrlStrings[productDetails.asin] {
                            URLImage(urlStrings: [graphImageUrlStrings], width: 280, height: 300, aspectRatio: .fit, backgroundColor: .clear, cornerRadius: 0)
                                .frame(height: 100)
                                .padding()
                        }
                    }
                        }
                    } else {
                Text("Loading products...")
            }
        }
    }
    
    private func fetchImages(for productDetails: [ProductDetails]) {
        for product in productDetails {
            let parameters = GraphImageParameters(asin: product.asin)
            viewModel.fetch(for: .imageGraph(parameters))
        }
    }
}

#Preview {
    ProductView()
}
