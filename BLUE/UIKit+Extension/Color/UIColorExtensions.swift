//
//  UIColorExtensions.swift
//  StructureApp
// 
//  Created By: Bhikhu
//  Created on: 11/11/17 10:25 AM - (Bhikhu)
//  
//  Copyright © 2017 Bhikhu. All rights reserved.
//  
//  

#if canImport(UIKit)
import UIKit
/// Color
public typealias Color = UIColor
#endif

#if canImport(Cocoa)
import Cocoa
/// Color
public typealias Color = NSColor
#endif

#if !os(watchOS)
import CoreImage
#endif

// MARK: - Application colors
public extension UIColor {
    
    /// The Structure for defining the colors for the Button
    struct Color {
        
        static let buttonColor = UIColor(named: "ButtonColor")!
        static let green = UIColor(named: "Green")!
        static let red = UIColor(named: "Red")!
        static let lightBlack60 = UIColor(named: "lightBlack60")!
        
        static let colorC7E2FE = UIColor(named: "colorC7E2FE")!
        static let colorD6F0F5 = UIColor(named: "colorD6F0F5")!
        
        static let color47A1FF = UIColor(named: "color47A1FF")!
        static let color528D99 = UIColor(named: "color528D99")!
        static let blueViewColor = UIColor(named: "BlueViewColor")!
        
        
 
        
        
        
    }
}

public extension UIColor {
    
    /// - Parameters:
    ///   - hex: Hex String of the color. example: "95A5A6" or "#95A5A6"
    ///
    /// - Returns:
    /// The color object. The color information represented by this object is in an RGB colorspace. On applications linked for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is specified in a device RGB colorspace.
    convenience init(hex: String) {
        
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            let start = cString.index(cString.startIndex, offsetBy: 1)
            cString = String(cString[start...])
        }
        
        let rVal, gVal, bVal, aVal: CGFloat
        
        if cString.count == 6 {
            let scanner = Scanner(string: cString)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                rVal = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                gVal = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                bVal = CGFloat(hexNumber & 0x0000ff) / 255
                aVal = 1.0
                
                self.init(red: rVal, green: gVal, blue: bVal, alpha: aVal)
                return
            }
        }
        
        self.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return
        
    }
    
    /// Initializes and returns a color object using the specified opacity and RGB component values.
    ///
    ///
    ///
    ///     UIColor(red: 240, green: 240, blue: 240)
    /// or
    ///
    ///     UIColor(red: 240, green: 240, blue: 240, alpha: 1.0)
    ///
    ///
    /// - Parameters:
    ///   - red: The red value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, red values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - green: The green value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, green values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - blue: The blue value of the color object. On applications linked for iOS 10 or later, the color is specified in an extended color space, and the input value is never clamped. On earlier versions of iOS, blue values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///   - alpha: The opacity value of the color object, specified as a value from 0.0 to 1.0. Alpha values below 0.0 are interpreted as 0.0, and values above 1.0 are interpreted as 1.0.
    ///
    /// - Returns:
    /// The color object. The color information represented by this object is in an RGB colorspace. On applications linked for iOS 10 or later, the color is specified in an extended range sRGB color space. On earlier versions of iOS, the color is specified in a device RGB colorspace.
    convenience init(red: Int, green: Int, blue: Int, alpha: Float = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha))
    }
    
    /// Hexadecimal value string (read-only).
    var hexString: String {
        
        var rVal: CGFloat = 0
        var gVal: CGFloat = 0
        var bVal: CGFloat = 0
        var aVal: CGFloat = 0
        
        getRed(&rVal, green: &gVal, blue: &bVal, alpha: &aVal)
        
        let rgb: Int = (Int)(rVal*255)<<16 | (Int)(gVal*255)<<8 | (Int)(bVal*255)<<0
        
        return String(format: "#%06x", rgb)
        
    }
    
    // swiftlint:disable next large_tuple
    /// SwifterSwift: RGB components for a Color (between 0 and 255).
    ///
    ///        UIColor.red.rgbComponents.red -> 255
    ///        NSColor.green.rgbComponents.green -> 255
    ///        UIColor.blue.rgbComponents.blue -> 255
    ///
    var rgbComponents: (red: Int, green: Int, blue: Int) {
        var components: [CGFloat] {
            let comps = cgColor.components!
            if comps.count == 4 { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0))
    }
    
    /// Random color in Swift 4.0
    static var random: UIColor {
        let randomRed: CGFloat = .random()
        let randomGreen: CGFloat = .random()
        let randomBlue: CGFloat = .random()
        
        return self.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 0.5)
    }
    
    /**
     The six-digit hexadecimal representation of color of the form #RRGGBB.
     
     - parameter hex6: Six-digit hexadecimal value.
     */
    convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
}
// GET THE COLOR PROPERTIES

extension UIColor {
    
    func inverse () -> UIColor {
        var r: CGFloat = 0.0; var g: CGFloat = 0.0; var b: CGFloat = 0.0; var a: CGFloat = 0.0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return .black // Return a default colour
    }
    
    /**
     Determines if the color object is dark or light.
     
     It is useful when you need to know whether you should display the text in black or white.
     
     - returns: A boolean value to know whether the color is light. If true the color is light, dark otherwise.
     */
    func isLight() -> Bool {
        
        let components = toRGBAComponents()
        let brightness = ((components.r * 299.0) + (components.g * 587.0) + (components.b * 114.0)) / 1000.0
        
        return brightness >= 0.5
    }
    
    /**
     Returns the RGBA (red, green, blue, alpha) components.
     
     - returns: The RGBA components as a tuple (r, g, b, a).
     */
    final func toRGBAComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        #if os(iOS) || os(tvOS) || os(watchOS)
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
        #elseif os(OSX)
        guard let rgbaColor = self.usingColorSpace(.deviceRGB) else {
            fatalError("Could not convert color to RGBA.")
        }
        
        rgbaColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return (r, g, b, a)
        #endif
    }
    
}
