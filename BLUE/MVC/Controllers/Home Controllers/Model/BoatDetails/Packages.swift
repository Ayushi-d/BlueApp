//
//  Packages.swift
//
//  Created by Bhikhu on 19/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class Packages {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let features = "features"
    static let name = "name"
    static let updatedAt = "updated_at"
    static let id = "id"
    static let createdAt = "created_at"
    static let price = "price"
  }

  // MARK: Properties
  public var features: String?
  public var name: String?
  public var updatedAt: String?
  public var id: Int?
  public var createdAt: String?
  public var price: String?
    public var isAdded: Bool = false

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
    features = json[SerializationKeys.features].string
    name = json[SerializationKeys.name].string
    updatedAt = json[SerializationKeys.updatedAt].string
    id = json[SerializationKeys.id].int
    createdAt = json[SerializationKeys.createdAt].string
    price = json[SerializationKeys.price].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = features { dictionary[SerializationKeys.features] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

}
