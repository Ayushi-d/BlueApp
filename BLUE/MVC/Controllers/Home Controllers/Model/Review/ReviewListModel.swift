//
//  ReviewListModel.swift
//  BLUE
//
//  Created by MacBook M1 on 29/11/22.
//

import Foundation
import SwiftyJSON

public class ReviewListModel{

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let review = "review"
    static let message = "message"
    static let type = "type"
//    static let lastPage = "last_page"
  }

  // MARK: Properties
  public var status: Int?
  public var review: [ReviewData]?
  public var message: String?
  public var type: String?
//  public var lastPage: Int?

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
    status = json[SerializationKeys.status].int
    if let items = json[SerializationKeys.review].array { review = items.map { ReviewData(json: $0) } }
    message = json[SerializationKeys.message].string
    type = json[SerializationKeys.type].string
//    lastPage = json[SerializationKeys.lastPage].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = review { dictionary[SerializationKeys.review] = value.map { $0.dictionaryRepresentation() } }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = type { dictionary[SerializationKeys.type] = value }
//    if let value = lastPage { dictionary[SerializationKeys.lastPage] = value }
    return dictionary
  }

}
