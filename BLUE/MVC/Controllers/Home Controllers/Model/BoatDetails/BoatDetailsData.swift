//
//  Data.swift
//
//  Created by Bhikhu on 19/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class BoatDetailsData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let featuredImage = "featured_image"
    static let name = "name"
    static let facilities = "facilities"
    static let destinationAddress = "destination_address"
    static let pickupAddress = "pickup_address"
    static let descriptionValue = "description"
    static let toDate = "to_date"
    static let category = "category"
    static let packages = "packages"
    static let memberAllowed = "member_allowed"
    static let id = "id"
    static let fromDate = "from_date"
    static let startingFrom = "starting_from"
    static let createdAt = "created_at"
    static let subCategory = "sub_category"
    static let boatRating = "boat_rating"
    static let lat = "latitude"
    static let long = "longitude"


  }

  // MARK: Properties
  public var featuredImage: String?
  public var name: String?
  public var facilities: [Facilities]?
  public var destinationAddress: [DestinationAddress]?
  public var pickupAddress: String?
  public var descriptionValue: String?
  public var toDate: String?
  public var category: Int?
  public var packages: [Packages]?
  public var memberAllowed: Int?
  public var id: Int?
  public var fromDate: String?
  public var startingFrom: String?
  public var createdAt: String?
  public var subCategory: Int?
  public var boatRating: String?
  public var lat: String?
  public var long: String?


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
    featuredImage = json[SerializationKeys.featuredImage].string
    name = json[SerializationKeys.name].string
    if let items = json[SerializationKeys.facilities].array { facilities = items.map { Facilities(json: $0) } }
    if let items = json[SerializationKeys.destinationAddress].array { destinationAddress = items.map { DestinationAddress(json: $0) } }
    pickupAddress = json[SerializationKeys.pickupAddress].string
    descriptionValue = json[SerializationKeys.descriptionValue].string
    toDate = json[SerializationKeys.toDate].string
    category = json[SerializationKeys.category].int
    if let items = json[SerializationKeys.packages].array { packages = items.map { Packages(json: $0) } }
    memberAllowed = json[SerializationKeys.memberAllowed].int
    id = json[SerializationKeys.id].int
    fromDate = json[SerializationKeys.fromDate].string
    startingFrom = json[SerializationKeys.startingFrom].string
    createdAt = json[SerializationKeys.createdAt].string
    boatRating = json[SerializationKeys.boatRating].string
    subCategory = json[SerializationKeys.subCategory].int
    lat = json[SerializationKeys.lat].string
    long = json[SerializationKeys.long].string

  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = featuredImage { dictionary[SerializationKeys.featuredImage] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = facilities { dictionary[SerializationKeys.facilities] = value.map { $0.dictionaryRepresentation() } }
    if let value = destinationAddress { dictionary[SerializationKeys.destinationAddress] = value.map { $0.dictionaryRepresentation() } }
    if let value = pickupAddress { dictionary[SerializationKeys.pickupAddress] = value }
    if let value = descriptionValue { dictionary[SerializationKeys.descriptionValue] = value }
    if let value = toDate { dictionary[SerializationKeys.toDate] = value }
    if let value = category { dictionary[SerializationKeys.category] = value }
    if let value = packages { dictionary[SerializationKeys.packages] = value.map { $0.dictionaryRepresentation() } }
    if let value = memberAllowed { dictionary[SerializationKeys.memberAllowed] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = fromDate { dictionary[SerializationKeys.fromDate] = value }
    if let value = startingFrom { dictionary[SerializationKeys.startingFrom] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    if let value = boatRating { dictionary[SerializationKeys.boatRating] = value }
    if let value = subCategory { dictionary[SerializationKeys.subCategory] = value }
    if let value = lat { dictionary[SerializationKeys.lat] = value }
    if let value = long { dictionary[SerializationKeys.long] = value }

    return dictionary
  }

}
