//
//  MyBoatsModel.swift
//  BLUE
//
//

import Foundation

struct MyBoatsBookingModel: Codable{
    let id: Int?
    let name: String?
    let status: String?
    let grand_total: String?
    let image: String?
    let start: String?
    let end: String?
    let total: String?
    let product:[Product]?
    let package_name: String?
    let package_price: String?
    let pickup_address: String?
    let coupon_amount: String?
    
}

struct Product: Codable{
    let name: String?
    let grand_total: String?
}
