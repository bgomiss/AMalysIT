//
//  ProductView.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024.
//

import SwiftUI

struct ProductView: View {
    @StateObject var viewModel = ProductViewModel()
    @State var parameters: GraphImageParameters?
    
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
                viewModel.fetch(for: .productSearch("lotion"))
            }
            .onChange(of: viewModel.productDetails ?? []) { _ ,newProductDetails in
                fetchImages(for: newProductDetails)
                //viewModel.fetch(for: .singleProductDetails(parameters ?? GraphImageParameters(asin: "B00ROXCLJ4")))
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
                            Text("")
                            Text(productDetails.brand ?? "")
                            Text(productDetails.title)
                            
                        }
                        if let graphImageUrlStrings = viewModel.graphImageUrlStrings[productDetails.asin] {
                            if let historicalPrices = viewModel.historicalPrices[productDetails.asin] {
                                NavigationLink(destination: ChartView(historicalPrices: historicalPrices)) {
                                    URLImage(urlStrings: [graphImageUrlStrings], width: 280, height: 300, aspectRatio: .fit, backgroundColor: .clear, cornerRadius: 0)
                                        .frame(height: 100)
                                        .padding()
                                }
                            }
                        }
                        
                        if let singleProduct = viewModel.singleProductAnalysis[productDetails.asin] {
                            let buyBoxPrice = singleProduct.stats?.buyBoxPrice
                            if let price = buyBoxPrice {
                                Text("Price is: \(Helper.formattedPrice(from: price))")
                            }
                        }
                        
                        if let historicalPrices = viewModel.historicalPrices[productDetails.asin] {
                            ForEach(historicalPrices.sorted(by: { $0.key < $1.key }), id: \.key) { date, price in
                                Text("Price: \(Helper.formattedPrice(from: price)) - Date: \(date, formatter: Helper.dateFormatter)")
                            }
                        }
                    }
                }
            }  else {
                Text("Loading products...")
            }
        }
    }
    
    
    private func fetchImages(for productDetails: [ProductDetails]) {
        for product in productDetails {
            parameters = GraphImageParameters(asin: product.asin)
            viewModel.fetch(for: .imageGraph(parameters ?? GraphImageParameters(asin: "B00ROXCLJ4")))
            viewModel.fetch(for: .singleProductDetails(parameters!))
            
            }
        }
    }

    
    #Preview {
        ProductView()
    }

