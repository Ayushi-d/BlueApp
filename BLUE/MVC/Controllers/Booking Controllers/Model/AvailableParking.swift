//
//  AvailableParking.swift
//  BLUE
//
//

import Foundation


struct AvailableParking: Codable{
    let id: Int?
        let name, image, parkingStatus, lat: String?
        let long, fromDate, toDate, priceType: String?
        let price: String?

        enum CodingKeys: String, CodingKey {
            case id, name, image
            case parkingStatus = "parking_status"
            case lat, long
            case fromDate = "from_date"
            case toDate = "to_date"
            case priceType = "price_type"
            case price
        }
}
