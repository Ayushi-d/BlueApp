//
//  Data.swift
//
//  Created by Bhikhu on 18/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class HomeData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let category = "category"
    static let subCategory = "sub_category"
  }

  // MARK: Properties
  public var category: [Category]?
  public var subCategory: [SubCategory]?

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
    if let items = json[SerializationKeys.category].array { category = items.map { Category(json: $0) } }
    if let items = json[SerializationKeys.subCategory].array { subCategory = items.map { SubCategory(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = category { dictionary[SerializationKeys.category] = value.map { $0.dictionaryRepresentation() } }
    if let value = subCategory { dictionary[SerializationKeys.subCategory] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
