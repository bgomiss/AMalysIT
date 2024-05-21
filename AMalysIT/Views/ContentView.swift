//
//  ContentView.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import SwiftUI
import Charts

struct URLImage: View {
    let urlStrings: [String]
    
    @State var data: [Data?] = []
    @StateObject var viewModel = URLImageViewModel()
    
    init(urlStrings: [String]) {
           self.urlStrings = urlStrings
           self._data = State(initialValue: Array(repeating: nil, count: urlStrings.count))
       }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(urlStrings.indices, id: \.self) { index in
                    if let data = data[index], let uiimage = UIImage(data: data) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100)
                            .background(Color.gray)
                            .cornerRadius(8)
                    }
                    else {
                        Image(systemName: "arrow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .cornerRadius(8)
                            .onAppear {
                                viewModel.fetchData(at: index, urlString: urlStrings[index])
                            }
                    }
                }
                }
            }
        }
        
       
}



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
           
            }
        }
    }


#Preview {
    ContentView()
}
