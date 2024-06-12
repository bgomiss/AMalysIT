//
//  ChartView.swift
//  AMalysIT
//
//  Created by aycan duskun on 8.06.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State private var chartData: [ChartData] = []
    @State private var selectedDate: Date?
    @State private var selectedPrice: Double?

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
            
            // Load sample data
            Button("Load Data") {
                loadSampleData()
            }
        }
    }
    
    private func loadSampleData() {
        // Simulate loading data from API
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        chartData = [
            ChartData(date: dateFormatter.date(from: "2024-03-16")!, price: 15.0),
            ChartData(date: dateFormatter.date(from: "2024-04-01")!, price: 16.0),
            ChartData(date: dateFormatter.date(from: "2024-04-16")!, price: 14.0),
            ChartData(date: dateFormatter.date(from: "2024-05-01")!, price: 17.0),
            ChartData(date: dateFormatter.date(from: "2024-05-16")!, price: 18.0),
            ChartData(date: dateFormatter.date(from: "2024-06-01")!, price: 19.0)
        ]
    }
    
  
    
    private func findClosestData(to date: Date) -> ChartData? {
        chartData.min(by: { abs($0.date.timeIntervalSince1970 - date.timeIntervalSince1970) < abs($1.date.timeIntervalSince1970 - date.timeIntervalSince1970) })
    }
}

#Preview {
    ChartView()
}

