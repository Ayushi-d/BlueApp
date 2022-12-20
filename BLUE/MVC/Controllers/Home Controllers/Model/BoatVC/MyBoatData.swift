//
//  MyBoatData.swift
//  BLUE
//
//  Created by MacBook M1 on 29/11/22.
//

import Foundation
import SwiftyJSON

public class MyBoatData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
      static let id = "id"
      static let name = "name"
      static let height = "height"
      static let width = "width"
      static let boat_type = "boat_type"
      static let image = "image"
     

  }

  // MARK: Properties
    public var id: Int?
    public var name: String?
    public let height: String?
    public let width: String?
    public let boat_type: String?
    public var image: [String]?


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
      name = json[SerializationKeys.name].string
      height = json[SerializationKeys.height].string
      width = json[SerializationKeys.width].string
      boat_type = json[SerializationKeys.boat_type].string
      if let items = json[SerializationKeys.image].array { image = items.map{ "\($0)"} }
     
     
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = id { dictionary[SerializationKeys.id] = value }
      if let value = name { dictionary[SerializationKeys.name] = value }
      if let value = height { dictionary[SerializationKeys.height] = value }
      if let value = width { dictionary[SerializationKeys.width] = value }
      if let value = boat_type { dictionary[SerializationKeys.boat_type] = value }
      if let value = image { dictionary[SerializationKeys.image] = value.map { "\($0)" } }
    return dictionary
  }

}
