//
//  CartModel.swift
//  BLUE
//
//

import Foundation

struct CartModel: Codable{
    
    let id: Int?
    let name: String?
    let qty: Int?
    let total: String?
    let image: String?
    let product_id: Int?
    let product_price: String?
    let type: String?

}

struct ReviewBoatData: Codable{
    let product: [CustomerReviewData]?
    let entity_id: Int?
    
}

struct CustomerReviewData: Codable{
    let username: String?
    let review: String?
    let rating: String?
}
