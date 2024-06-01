//
//  ProductModel.swift
//  AMalysIT
//
//  Created by aycan duskun on 16.05.2024..
//

import Foundation

struct ProductModel: Hashable, Codable {
    
    let timestamp: Int
    let tokensLeft: Int
    let refillIn: Int
    let refillRate: Int
    let tokenFlowReduction: Int
    let tokensConsumed: Int
    let processingTimeInMs: Int
    let products: [ProductDetails]
    }

struct ProductDetails: Hashable, Codable {
    //var id: String { asin }
    let imagesCSV: String
    let title: String
    let type: String
    let asin: String
    let hasReviews: Bool
    let brand: String
    let size: String
    let color: String?
    let numberOfItems: Int
    let frequentlyBoughtTogether: [String]?
    let features: [String]
    let description: String
    let variations: [Variation]?
    
    var imageUrls: [String] {
            // Base URL for the images
            let baseUrl = "https://images-na.ssl-images-amazon.com/images/I/"
            return imagesCSV.split(separator: ",").map { baseUrl + $0.trimmingCharacters(in: .whitespaces) }
        }
    }

struct Variation: Hashable, Codable {
    let asin: String
    let attributes: [Attribute]
}

struct Attribute: Hashable, Codable {
    let dimension: String
    let value: String
}


