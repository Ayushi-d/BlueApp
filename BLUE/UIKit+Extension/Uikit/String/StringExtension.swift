//
//  Created by Unicorn
//  Copyright © Unicorn All rights reserved.
//  Created on 03/02/21

import Foundation
import UIKit

extension String {
    /// This method will check that if the string is Empty / Blank or not.
    ///
    ///     "This is your String!".isBlank      // Returns false
    ///
    var isBlank: Bool {
        return trimmed.isEmpty
    }

    /// Remove Whitespace from string.
    ///
    ///     " This is your String! ".trimWhitespace     // Returns This is your String!
    ///
    var trimWhitespace: String {
        let trimmedString = trimmingCharacters(in: .whitespaces)
        return trimmedString
    }

    /// String with no spaces or new lines in beginning and end.
    ///
    ///     "This is your String!\n ".isBlank      // Returns This is your String!
    ///
    var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// String decoded from NSAttributedStringase64  (if applicable).
    var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: decodedData, encoding: .utf8)
    }

    /// String encoded in base64 (if applicable).
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }

    /// This method will replace the string with other string.
    ///
    /// - Parameters:
    ///   - string: String which you wanted to replace.
    ///   - withString: String by which you want to replace 1st string.
    /// - Returns: Returns new string by replacing string
    func replace(string: String, withString: String) -> String {
        return replacingOccurrences(of: string, with: withString)
    }

    /// Double value from string (if applicable).
    var double: Double? {
        let formatter = NumberFormatter()
        return formatter.number(from: self) as? Double
    }

    /// Double value from string (if applicable).
    var doubleZeroDecimal: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: self) as? Double
    }

    /// Integer value from string (if applicable).
    var int: Int? {
        return Int(self)
    }

    /// URL from string (if applicable).
    var url: URL? {
        return URL(string: self)
    }

    /// Get length of string
    ///
    ///     let phrase = "The rain in Spain"
    ///     print(phrase.length)
    ///
    var length: Int {
        return count
    }

    /// Leading and Tralling from spaces from string
    ///
    /// - Returns: Update trimmed string
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /// To triming / removing particular character
    ///
    /// - Parameter char: Character to trim
    /// - Returns: Updated string
    func trim(char: Character) -> String {
        return trimmingCharacters(in: CharacterSet(charactersIn: "\(char)"))
    }

    /// To triming / removing string
    ///
    /// - Parameter charsInString: String to trim
    /// - Returns: Updated string
    func trim(charsInString: String) -> String {
        return trimmingCharacters(in: CharacterSet(charactersIn: charsInString))
    }

    /// Convert json string to json object
    ///
    /// - Parameter
    /// - Returns: Json Object
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = capitalizingFirstLetter()
    }

 func convertToDictionary() -> [String: Any]? {
     if let data = self.data(using: .utf8) {
         do {
             return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
         } catch {
             print(error.localizedDescription)
         }
     }
     return nil
 }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
extension String {
    static var bullet: String {
        return "  •  "
    }
}
