//
//  ProductListModel.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import SwiftyJSON

public class ProductList{
    
    private struct SerializationKeys {
        static let id = "id"
        static let name = "name"
        static let image = "image"
        static let price = "price"
        static let description = "description"
    }
    
    public var name: String?
    public var price: String?
    public var id: Int?
    public var image: String?
    public var description: String?
    
    public convenience init(object: Any) {
      self.init(json: JSON(object))
    }
    public required init(json: JSON) {
      name = json[SerializationKeys.name].string
      description = json[SerializationKeys.description].string
      id = json[SerializationKeys.id].int
      image = json[SerializationKeys.image].string
      price = json[SerializationKeys.price].string
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = name { dictionary[SerializationKeys.name] = value }
      if let value = description { dictionary[SerializationKeys.description] = value }
      if let value = id { dictionary[SerializationKeys.id] = value }
      if let value = image { dictionary[SerializationKeys.image] = value }
      if let value = price { dictionary[SerializationKeys.price] = value }
      return dictionary
    }
}
