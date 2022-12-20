//
//  ParkingListModel.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import SwiftyJSON

public class ParkingDataModel {
        
    private struct SerializationKeys {
            static let id = "id"
            static let name = "name"
            static let image = "image"
            static let price = "price"
            static let parking_status = "parking_status"
            static let lat = "lat"
            static let long = "long"
            static let from_date = "from_date"
            static let to_date = "to_date"
            static let price_type = "price_type"
          
        }
        
        public var name: String?
        public var price: String?
        public var id: Int?
        public var image: String?
        public var parking_status: String?
        public var lat: String?
        public var long: String?
        public var from_date: String?
        public var to_date: String?
        public var price_type: String?
        
        public convenience init(object: Any) {
          self.init(json: JSON(object))
        }
        public required init(json: JSON) {
          name = json[SerializationKeys.name].string
          parking_status = json[SerializationKeys.parking_status].string
          id = json[SerializationKeys.id].int
          image = json[SerializationKeys.image].string
          price = json[SerializationKeys.price].string
          lat = json[SerializationKeys.lat].string
          long = json[SerializationKeys.long].string
          from_date = json[SerializationKeys.from_date].string
          to_date = json[SerializationKeys.to_date].string
          price_type = json[SerializationKeys.price_type].string
        }
        
        public func dictionaryRepresentation() -> [String: Any] {
          var dictionary: [String: Any] = [:]
          if let value = name { dictionary[SerializationKeys.name] = value }
          if let value = parking_status { dictionary[SerializationKeys.parking_status] = value }
          if let value = id { dictionary[SerializationKeys.id] = value }
          if let value = image { dictionary[SerializationKeys.image] = value }
          if let value = price { dictionary[SerializationKeys.price] = value }
          if let value = lat { dictionary[SerializationKeys.lat] = value }
          if let value = long { dictionary[SerializationKeys.long] = value }
          if let value = from_date { dictionary[SerializationKeys.from_date] = value }
          if let value = to_date { dictionary[SerializationKeys.to_date] = value }
          if let value = price_type { dictionary[SerializationKeys.price_type] = value }
          return dictionary
        }
    }
