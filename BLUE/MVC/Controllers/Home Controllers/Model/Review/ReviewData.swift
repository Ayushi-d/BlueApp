//
//  ReviewData.swift
//  BLUE
//
//  Created by MacBook M1 on 29/11/22.
//

import Foundation
import SwiftyJSON

public class ReviewData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
     
      static let username = "username"
      static let review = "review"
      static let rating = "rating"
  
  }

  // MARK: Properties
    public var username: String?
    public let review: String?
    public let rating: String?
   
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
     
      username = json[SerializationKeys.username].string
      review = json[SerializationKeys.review].string
      rating = json[SerializationKeys.rating].string
          
  }
  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = username { dictionary[SerializationKeys.username] = value }
      if let value = review { dictionary[SerializationKeys.review] = value }
      if let value = rating { dictionary[SerializationKeys.rating] = value }
    return dictionary
  }

}
