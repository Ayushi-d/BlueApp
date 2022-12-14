//
//  Data.swift
//
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AddBoatData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let boatId = "boat_owner_id"
  }

  // MARK: Properties
  public var boatId: Int?

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
      boatId = json[SerializationKeys.boatId].int  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = boatId { dictionary[SerializationKeys.boatId] = value }
    return dictionary
  }

}
