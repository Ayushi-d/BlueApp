import Foundation
import UIKit

enum fontEnum: String {
    case SourceSansProRegular = "SourceSansPro-Regular"
    case SourceSansProExtraLight = "SourceSansPro-ExtraLight"
    case SourceSansProBold = "SourceSansPro-Bold"
    case SourceSansProBoldItalic = "SourceSansPro-BoldItalic"
    case SourceSansProBlack = "SourceSansPro-Black"
    case SourceSansProBlackItalic = "SourceSansPro-BlackItalic"
    case SourceSansProSemiBold = "SourceSansPro-SemiBold"
}

extension UIFont {

    // HOW TO USE : UIFont.OpenSansRegular(16.0)

    private class func fontWithName(name: String, Size: CGFloat ) -> UIFont {
        return UIFont(name: name, size: Size)!
    }

    // Example font
    // Please update it
    class func sourceSansProRegular(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProRegular.rawValue, Size: size)
    }
    class func sourceSansProExtraLight(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProExtraLight.rawValue, Size: size)
    }
    class func sourceSansProBold(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProBold.rawValue, Size: size)
    }
    class func sourceSansProBoldItalic(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProBoldItalic.rawValue, Size: size)
    }
    class func sourceSansProBlack(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProBlack.rawValue, Size: size)
    }
    class func sourceSansProBlackItalic(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProBlackItalic.rawValue, Size: size)
    }
    class func SourceSansProSemiBold(size: CGFloat) -> UIFont {
        return self.fontWithName(name: fontEnum.SourceSansProSemiBold.rawValue, Size: size)
    }

}

/// Enum for App Font sizes
enum FontSize: CGFloat {
    /// header = 15
    case headerRegular = 15
    /// largeTitle = 24
    case largeTitle = 24
    /// title = 16
    case title = 16
    /// subtitle = 18
    case regularTitle = 18
    /// secondarySubtitle = 13
    case secondarySubtitle = 13

    /// home cell small = 11
    case homesmall = 11

    /// video details cell small = 12
    case videodetailssmall = 12

    /// 20
    case LargeMedium = 20

    // navigation title = 17
    case navigationTitle = 17

    case medium = 14

    case bold = 32
    
    case bold22 = 22
}

extension UIFont {

    var bold: UIFont {
        return with(.traitBold)
    }

    var italic: UIFont {
        return with(.traitItalic)
    }

    var boldItalic: UIFont {
        return with([.traitBold, .traitItalic])
    }

    /// This will return the scalled font as per the native iOS setting. Please note that this will work with your custom font as well. :)
    ///
    ///     UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.heavy).scaled
    var scaled: UIFont {
        return UIFontMetrics.default.scaledFont(for: self)
    }

    func with(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits).union(self.fontDescriptor.symbolicTraits)) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

    func without(_ traits: UIFontDescriptor.SymbolicTraits...) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(self.fontDescriptor.symbolicTraits.subtracting(UIFontDescriptor.SymbolicTraits(traits))) else {
            return self
        }
        return UIFont(descriptor: descriptor, size: 0)
    }

}
