//
//  Helper.swift
//  AMalysIT
//
//  Created by aycan duskun on 5.06.2024.
//

import Foundation

enum Helper {
    static func formattedPrice(from price: Int) -> String {
           let decimalPrice = Double(price) / 100.0
           return String(format: "$%.2f", decimalPrice)
       }
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
