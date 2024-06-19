//
//  ChartView.swift
//  AMalysIT
//
//  Created by aycan duskun on 8.06.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var chartData: [ChartData] = []
    @State private var selectedDate: Date?
    @State private var selectedPrice: Double?
    @State var parameters: GraphImageParameters?
    let historicalPrices: [Date: Int]

    var body: some View {
        VStack {
            if let selectedDate = selectedDate, let selectedPrice = selectedPrice {
                Text("Selected Date: \(selectedDate, formatter: Helper.dateFormatter)")
                Text("Selected Price: \(selectedPrice, specifier: "%.2f")")
            }


            Chart {
                ForEach(chartData) { data in
                    LineMark(
                        x: .value("Date", data.date),
                        y: .value("Price", data.price)
                    )
                }
            }
            .chartOverlay { proxy in
                GeometryReader { geometry in
                    Rectangle().fill(.clear).contentShape(Rectangle())
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location
                                    if let date = proxy.value(atX: location.x, as: Date.self) {
                                        if let closestData = findClosestData(to: date) {
                                            selectedDate = closestData.date
                                            selectedPrice = closestData.price
                                        }
                                    }
                                }
                        )
                }
            }
            .frame(height: 300)
            .padding()
        }
        .onAppear {
            loadChartData()

               }
        }
    
        private func loadChartData() {
            let sortedPrices = historicalPrices.sorted(by: { $0.key < $1.key })
            chartData = sortedPrices.map { ChartData(date: $0.key, price: Double($0.value)) }
        }
  
    
    private func findClosestData(to date: Date) -> ChartData? {
        chartData.min(by: { abs($0.date.timeIntervalSince1970 - date.timeIntervalSince1970) < abs($1.date.timeIntervalSince1970 - date.timeIntervalSince1970) })
    }
}

#Preview {
    ChartView(historicalPrices: [Date(): 9])
}

