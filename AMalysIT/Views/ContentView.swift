//
//  ContentView.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import SwiftUI
import Charts



struct ContentView: View {
    @StateObject var viewModel = SellerViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                //ForEach(viewModel.analysis?.seller, id: \.self) { analysis in
                if let sortedSellers = viewModel.analysis?.sellers.sorted(by: { $0.key < $1.key }) {
                    
                    ForEach(sortedSellers, id: \.key) { (key, seller) in
                        VStack {
                            HStack {
                                // URLImage(urlString: analysis)
                                
                                Text(seller.businessName)
                                    .bold()
                                Spacer()
                                Text(seller.phoneNumber)
                            }
                            .padding(3)
                            ForEach(0..<seller.address.count, id: \.self) { index in
                                HStack {
                                    Text(seller.address[index])
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                Chart {
                    ForEach(0..<5, id: \.self) { index in
                        BarMark(
                            x: .value("Seller", "Seller \(index)"),
                            y: .value("Sales", Double.random(in: 5...15))
                        )
                        .foregroundStyle(by: .value("Seller", "Seller \(index)"))
                    }
                }
                .frame(height: 200)
                .chartXAxis {
                    AxisMarks(values: .stride(by: 1)) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                .chartYAxis {
                    AxisMarks(values: .stride(by: 5)) { _ in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                
            }
            .navigationTitle("AMAZON")
            .onAppear {
                viewModel.fetch()
            }
            
            NavigationLink(destination: ProductView()) {
                                Text("Go to Product View")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }
            Spacer()
           
            }
        }
    }


#Preview {
    ContentView()
}
