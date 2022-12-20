//
//  DestinationAddress.swift
//
//  Created by Bhikhu on 19/10/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class DestinationAddress {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let boatsId = "boats_id"
    static let id = "id"
    static let destinationAddress = "destination_address"
    static let destinationHrs = "destination_hrs"
    static let price = "price"
  }

  // MARK: Properties
  public var boatsId: Int?
  public var id: Int?
  public var destinationAddress: String?
  public var destinationHrs: Int?
  public var price: String?

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
    boatsId = json[SerializationKeys.boatsId].int
    id = json[SerializationKeys.id].int
    destinationAddress = json[SerializationKeys.destinationAddress].string
    destinationHrs = json[SerializationKeys.destinationHrs].int
    price = json[SerializationKeys.price].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = boatsId { dictionary[SerializationKeys.boatsId] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = destinationAddress { dictionary[SerializationKeys.destinationAddress] = value }
    if let value = destinationHrs { dictionary[SerializationKeys.destinationHrs] = value }
    if let value = price { dictionary[SerializationKeys.price] = value }
    return dictionary
  }

}
