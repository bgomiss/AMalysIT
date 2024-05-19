//
//  Model.swift
//  AMalysIT
//
//  Created by aycan duskun on 14.05.2024.
//

import Foundation

struct SellerModel: Hashable, Codable {
    
        let timestamp: Int
        let tokensLeft: Int
        let refillIn: Int
        let refillRate: Int
        let tokenFlowReduction: Int
        let tokensConsumed: Int
        let processingTimeInMs: Int
        let sellers: [String : SellerDetails]
    }

    struct SellerDetails: Hashable, Codable {
        let trackedSince: Int
        let domainId: Int
        let sellerId: String
        let sellerName: String
        //let csv: [Int] // Assuming it's an array of any type
        let lastUpdate: Int
        let isScammer: Bool
        let hasFBA: Bool
        let totalStorefrontAsins: [Int]
        let sellerCategoryStatistics: [SellerCategoryStatistic]
        let sellerBrandStatistics: [SellerBrandStatistic]
        let shipsFromChina: Bool
        let address: [String]
        let recentFeedback: [RecentFeedback]
        let lastRatingUpdate: Int
        let neutralRating: [Int]
        let negativeRating: [Int]
        let positiveRating: [Int]
        let ratingCount: [Int]
        let phoneNumber: String
        let businessName: String
        let currentRating: Int
        let currentRatingCount: Int
        let ratingsLast30Days: Int
    }

    struct SellerCategoryStatistic: Hashable, Codable {
        let catId: Int
        let productCount: Int
        let avg30SalesRank: Int
        let productCountWithAmazonOffer: Int
    }

    struct SellerBrandStatistic: Hashable, Codable {
        let brand: String
        let productCount: Int
        let avg30SalesRank: Int
        let productCountWithAmazonOffer: Int
    }

    struct RecentFeedback: Hashable, Codable {
        let rating: Int
        let date: Int
        let feedback: String
        let isStriked: Bool
    }

