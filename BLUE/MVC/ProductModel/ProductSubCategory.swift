//
//  ProductSubCategory.swift
//  BLUE
//
//  Created by MacBook M1 on 15/11/22.
//

import Foundation
import SwiftyJSON

public class ProductSubCategory {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let updatedAt = "updated_at"
    static let id = "id"
    static let image = "image"
    static let createdAt = "created_at"
    static let category_id = "category_id"
      
  }

  // MARK: Properties
  public var name: String?
  public var updatedAt: String?
  public var id: Int?
  public var image: String?
  public var createdAt: String?
  public var category_id: Int?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    name = json[SerializationKeys.name].string
    updatedAt = json[SerializationKeys.updatedAt].string
    id = json[SerializationKeys.id].int
    category_id = json[SerializationKeys.category_id].int
    image = json[SerializationKeys.image].string
    createdAt = json[SerializationKeys.createdAt].string
    
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = category_id { dictionary[SerializationKeys.category_id] = value }
    return dictionary
  }

}
