//
//  ProductDetails.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import SwiftyJSON

public class ProductDetails{
    
    private struct SerializationKeys {
        static let id = "id"
        static let name = "name"
        static let image = "image"
        static let price = "price"
        static let description = "description"
        static let category_name = "category_name"
        static let sub_category_name = "sub_category_name"
        static let stock = "stock"
        
        
    }
    
    public var name: String?
    public var price: String?
    public var id: Int?
    public var image: String?
    public var description: String?
    public var category_name: String?
    public var sub_category_name: String?
    public var stock: Int?
    
    public convenience init(object: Any) {
      self.init(json: JSON(object))
    }
    public required init(json: JSON) {
      name = json[SerializationKeys.name].string
      description = json[SerializationKeys.description].string
      id = json[SerializationKeys.id].int
      image = json[SerializationKeys.image].string
      price = json[SerializationKeys.price].string
      category_name = json[SerializationKeys.category_name].string
      sub_category_name = json[SerializationKeys.sub_category_name].string
      stock = json[SerializationKeys.stock].int
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = name { dictionary[SerializationKeys.name] = value }
      if let value = description { dictionary[SerializationKeys.description] = value }
      if let value = id { dictionary[SerializationKeys.id] = value }
      if let value = image { dictionary[SerializationKeys.image] = value }
      if let value = price { dictionary[SerializationKeys.price] = value }
      if let value = stock { dictionary[SerializationKeys.stock] = value }
      if let value = category_name { dictionary[SerializationKeys.category_name] = value }
      if let value = sub_category_name { dictionary[SerializationKeys.sub_category_name] = value }
      return dictionary
    }
}
