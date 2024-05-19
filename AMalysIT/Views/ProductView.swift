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
                    if let products = viewModel.analysis?.products {
                        ForEach(products, id: \.self) { product in

                            VStack {
                                HStack {
                                    Text(product.size)
                                        .bold()
                                    Spacer()
                                    URLImage(urlString: product.imageUrls!)
                                    //Text(product.title)
                                }
                                .padding(3)
                                // Additional product details can be displayed here
                            }
                        }
                        
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
