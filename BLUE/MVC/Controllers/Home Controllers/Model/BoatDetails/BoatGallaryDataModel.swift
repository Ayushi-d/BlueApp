//
//  Data.swift
//
//  Created by Bhikhu on 22/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class BoatGallaryDataModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let image = "image"
    static let boatsId = "boats_id"
  }

  // MARK: Properties
  public var id: Int?
  public var image: String?
  public var boatsId: Int?

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
    id = json[SerializationKeys.id].int
    image = json[SerializationKeys.image].string
    boatsId = json[SerializationKeys.boatsId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = image { dictionary[SerializationKeys.image] = value }
    if let value = boatsId { dictionary[SerializationKeys.boatsId] = value }
    return dictionary
  }

}
