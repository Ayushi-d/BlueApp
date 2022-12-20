//
//  MyParkingModel.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import SwiftyJSON

public class MyParkingModel {
        
    private struct SerializationKeys {
            static let id = "id"
            static let parking_name = "parking_name"
            static let image = "image"
            static let price = "price"
            static let payment_status = "payment_status"
            static let payment_method = "payment_method"
            static let transaction_id = "transaction_id"
            static let from_date = "from_date"
            static let coupon_id = "coupon_id"
            static let to_date = "to_date"
            static let grand_total = "grand_total"
            static let created_at = "created_at"
        
         }
        
        public var parking_name: String?
        public var price: String?
        public var id: Int?
        public var image: String?
        public var payment_status: String?
        public var payment_method: String?
        public var transaction_id: String?
        public var from_date: String?
        public var to_date: String?
        public var coupon_id: String?
        public var grand_total: String?
        public var created_at: String?
        
        public convenience init(object: Any) {
          self.init(json: JSON(object))
        }
        public required init(json: JSON) {
          parking_name = json[SerializationKeys.parking_name].string
          payment_status = json[SerializationKeys.payment_status].string
          id = json[SerializationKeys.id].int
          image = json[SerializationKeys.image].string
          price = json[SerializationKeys.price].string
          payment_method = json[SerializationKeys.payment_method].string
          transaction_id = json[SerializationKeys.transaction_id].string
          from_date = json[SerializationKeys.from_date].string
          to_date = json[SerializationKeys.to_date].string
          coupon_id = json[SerializationKeys.coupon_id].string
          grand_total = json[SerializationKeys.grand_total].string
          created_at = json[SerializationKeys.created_at].string
            
        }
        
        public func dictionaryRepresentation() -> [String: Any] {
          var dictionary: [String: Any] = [:]
          if let value = parking_name { dictionary[SerializationKeys.parking_name] = value }
          if let value = payment_status { dictionary[SerializationKeys.payment_status] = value }
          if let value = id { dictionary[SerializationKeys.id] = value }
          if let value = image { dictionary[SerializationKeys.image] = value }
          if let value = price { dictionary[SerializationKeys.price] = value }
          if let value = payment_method { dictionary[SerializationKeys.payment_method] = value }
          if let value = transaction_id { dictionary[SerializationKeys.transaction_id] = value }
          if let value = from_date { dictionary[SerializationKeys.from_date] = value }
          if let value = to_date { dictionary[SerializationKeys.to_date] = value }
          if let value = coupon_id { dictionary[SerializationKeys.coupon_id] = value }
          if let value = grand_total { dictionary[SerializationKeys.grand_total] = value }
          if let value = created_at { dictionary[SerializationKeys.created_at] = value }
          return dictionary
        }
    }
