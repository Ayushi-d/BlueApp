//
//  CommonUtility.swift
//  BLUE
//
//

import Foundation
import UIKit

enum CommonUtility{
    
    static func addBoldTextToString(_ letterSpacing : CGFloat, lineHeight : CGFloat, underline : Int, textColor : UIColor, fullString: NSString, boldPartOfString: NSString, boldPartOfString2: NSString, font: UIFont!, boldFont: UIFont!, boldFontColor: UIColor) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!, NSAttributedString.Key.foregroundColor: boldFontColor]
        let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.minimumLineHeight = lineHeight // Whatever line spacing you want in points
        paragraphStyle.lineSpacing = 1.19
        boldString.addAttributes([NSAttributedString.Key.kern : CGFloat(letterSpacing), NSAttributedString.Key.foregroundColor : textColor, NSAttributedString.Key.paragraphStyle : paragraphStyle, NSAttributedString.Key.underlineStyle : underline], range: NSRange.init(location: 0, length: boldString.length))
        boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString as String))
        if boldPartOfString2 != "" {
            boldString.addAttributes(boldFontAttribute, range: fullString.range(of: boldPartOfString2 as String))
        }
        return boldString
    }
    
}
