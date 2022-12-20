//
//  User.swift
//
//  Created by Unicorn on 07/04/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class User: NSObject, NSCoding, NSSecureCoding {

    public static var supportsSecureCoding: Bool {
        get { return true }
    }

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let token = "token"
        static let first_name = "first_name"
        static let last_name = "last_name"
        static let email = "email"
        static let phone_no = "phone_no"
        static let civil_id = "civil_id"
        static let socialType = "socialType"

        
    }

    // MARK: Properties
    public var token: String?
    public var socialType: RegistationType = .normal

    public var first_name: String?
    public var last_name: String?
    public var email: String?
    public var phone_no: String?
    public var civil_id: String?
    public var fullname: String {
        return (first_name?.trimmed ?? "Someone") + " " + (last_name?.trimmed ?? "")
    }

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
        
        
        token = json[SerializationKeys.token].string
        first_name = json[SerializationKeys.first_name].string
        last_name = json[SerializationKeys.last_name].string
        email = json[SerializationKeys.email].string
        phone_no = json[SerializationKeys.phone_no].string
        civil_id = json[SerializationKeys.civil_id].string
        socialType = RegistationType(rawValue: json[SerializationKeys.socialType].string ?? "normal") ?? .normal

    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = token { dictionary[SerializationKeys.token] = value }
        if let value = first_name { dictionary[SerializationKeys.first_name] = value }
        if let value = last_name { dictionary[SerializationKeys.last_name] = value }
        if let value = phone_no { dictionary[SerializationKeys.phone_no] = value }
        if let value = civil_id { dictionary[SerializationKeys.civil_id] = value }
        if let value = email { dictionary[SerializationKeys.email] = value }
        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
        self.token = aDecoder.decodeObject(forKey: SerializationKeys.token) as? String
        self.first_name = aDecoder.decodeObject(forKey: SerializationKeys.first_name) as? String
        self.last_name = aDecoder.decodeObject(forKey: SerializationKeys.last_name) as? String
        self.phone_no = aDecoder.decodeObject(forKey: SerializationKeys.phone_no) as? String
        self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? String
        self.civil_id = aDecoder.decodeObject(forKey: SerializationKeys.civil_id) as? String
        self.socialType = RegistationType(rawValue: aDecoder.decodeObject(forKey: SerializationKeys.socialType) as? String ?? "normal") ?? .normal
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(email, forKey: SerializationKeys.email)
        aCoder.encode(token, forKey: SerializationKeys.token)
        aCoder.encode(first_name, forKey: SerializationKeys.first_name)
        aCoder.encode(last_name, forKey: SerializationKeys.last_name)
        aCoder.encode(phone_no, forKey: SerializationKeys.phone_no)
        aCoder.encode(civil_id, forKey: SerializationKeys.civil_id)
        aCoder.encode(socialType.rawValue, forKey: SerializationKeys.socialType)
    }
}
