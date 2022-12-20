//
//  SeafarerData.swift
//  BLUE
//
//  Created by MacBook M1 on 19/11/22.
//

import Foundation
import SwiftyJSON

public class SeafarerData {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
      static let id = "id"
      static let name = "name"
      static let phone_no = "phone_no"
      static let nationality = "nationality"
      static let category = "category"
      static let language = "language"
      static let experince = "experince"
      static let baot_experince = "baot_experince"
      static let license_number = "license_number"
      static let images = "images"
      static let created_at = "created_at"
      static let age = "age"

  }

  // MARK: Properties
    public var id: Int?
    public var name: String?
    public var phone_no: Int?
    public var nationality: String?
    public var category: String?
    public var language: String?
    public var experince: String?
    public var baot_experince: String?
    public var license_number: String?
    public var images: [String]?
    public var created_at: String?
    public var age : Int?
    

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
      phone_no = json[SerializationKeys.phone_no].int
      nationality = json[SerializationKeys.nationality].string
      category = json[SerializationKeys.category].string
      language = json[SerializationKeys.language].string
      experince = json[SerializationKeys.experince].string
      baot_experince = json[SerializationKeys.baot_experince].string
      license_number = json[SerializationKeys.license_number].string
      if let items = json[SerializationKeys.images].array { images = items.map{ "\($0)"} }
      created_at = json[SerializationKeys.created_at].string
      age = json[SerializationKeys.age].int
     
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
      if let value = id { dictionary[SerializationKeys.id] = value }
      if let value = name { dictionary[SerializationKeys.name] = value }
      if let value = phone_no { dictionary[SerializationKeys.phone_no] = value }
      if let value = nationality { dictionary[SerializationKeys.nationality] = value }
      if let value = category { dictionary[SerializationKeys.category] = value }
      if let value = language { dictionary[SerializationKeys.language] = value }
      if let value = baot_experince { dictionary[SerializationKeys.baot_experince] = value }
      if let value = license_number { dictionary[SerializationKeys.license_number] = value }
      if let value = images { dictionary[SerializationKeys.category] = value.map { "\($0)" } }
//      if let value = images { dictionary[SerializationKeys.images] = value }
      if let value = created_at { dictionary[SerializationKeys.created_at] = value }
      if let value = age { dictionary[SerializationKeys.age] = value }


    return dictionary
  }

}
