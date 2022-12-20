//
//  Data.swift
//
//  Created by Bhikhu on 18/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class BoatListDataModel {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startingFrom = "starting_from"
    static let featuredImage = "featured_image"
    static let name = "name"
    static let id = "id"
    static let pickupAddress = "pickup_address"
    static let createdAt = "created_at"
    static let boatRating = "boat_rating"
  }

  // MARK: Properties
  public var startingFrom: String?
  public var featuredImage: String?
  public var name: String?
  public var id: Int?
  public var pickupAddress: String?
  public var createdAt: String?
  public var boatRating: String?


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
    startingFrom = json[SerializationKeys.startingFrom].string
    featuredImage = json[SerializationKeys.featuredImage].string
    name = json[SerializationKeys.name].string
    id = json[SerializationKeys.id].int
    pickupAddress = json[SerializationKeys.pickupAddress].string
    createdAt = json[SerializationKeys.createdAt].string
    boatRating = json[SerializationKeys.boatRating].string

  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startingFrom { dictionary[SerializationKeys.startingFrom] = value }
    if let value = featuredImage { dictionary[SerializationKeys.featuredImage] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = pickupAddress { dictionary[SerializationKeys.pickupAddress] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = boatRating { dictionary[SerializationKeys.boatRating] = value }

    return dictionary
  }

}
