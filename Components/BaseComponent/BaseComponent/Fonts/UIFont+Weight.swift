// swiftlint:disable all
//
//  UIFont+Weight.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import UIKit

extension UIFont {
    /// Return true if the UIFont is light or extra light
    internal var isLightOrExtraLight: Bool {
        return fontName.lowercased().contains("light")
    }
    
    /// Return true if the UIFont is bold or semi bold
    internal var isBoldOrSemiBold: Bool {
        return fontName.lowercased().contains("bold")
    }
    
    /// Return true if the UIFont is italic
    internal var name: String {
        return String(fontName.split(separator: "-").first ?? "")
    }
    
    // MARK: -
    
    /// Returns the TextStyle of the UIFont
    internal var textStyle: TextStyle? {
        return (fontDescriptor.fontAttributes[.textStyle] as? String).map(TextStyle.init(rawValue:))
    }
    
    /// Returns the Font.Size of the UIFont
    internal var size: BaseFont.Size? {
        return textStyle.map({ .scaled(pointSize, style: $0) }) ?? .exactly(pointSize)
    }
    
    /// Returns the Font.Weight of the UIFont
    internal var weight: BaseFont.Weight? {
        var weightString = String(fontName.components(separatedBy: "-").last ?? "Regular")
        
        if let italicRange = weightString.range(of: "Italic") {
            weightString = String(weightString.prefix(upTo: italicRange.lowerBound))
            
            if weightString.isEmpty {
                return .regular
            }
        }
        
        return BaseFont.Weight(rawValue: weightString)
    }
    
    // MARK: -
    
    /// Returns a semibold version of the UIFont. If the font is already semibold or bold, it returns a bold version
    public var strong: UIFont {
        return at(weight: isBoldOrSemiBold ? .medium : .semiBold)
    }
    
    /// Returns a light version of the UIFont. If the font is already light or extra light, it returns a extra light version
    public var weak: UIFont {
        return at(weight: .light)
    }
    
    /// Returns an italic version of the UIFont
    public var emphasis: UIFont {
        return at(italic: true)
    }
    
    /// Returns a monospaced version of the UIFont
    public var monospaced: UIFont {
        guard let weight = weight, let size = size else {
            return self
        }
        
        return BaseFont.monospaced(weight: weight, fontName: name, size: size)
    }
    
    /// Returns a differently weighted UIFont at the same size and text style
    public func at(weight: BaseFont.Weight) -> UIFont {
        guard let size = size else {
            return self
        }
        
        return BaseFont.weight(weight, fontName: name, size: size)
    }
    
    /// Returns a differently sized UIFont at the same weight and text style
    public func at(size: BaseFont.Size) -> UIFont {
        guard let weight = weight else {
            return self
        }
        
        return BaseFont.weight(weight, fontName: name, size: size)
    }
    
    /// Returns a differently italicized UIFont at the same weight and size
    public func at(italic: Bool) -> UIFont {
        guard let weight = weight, let size = size else {
            return self
        }
        
        return BaseFont.weight(weight, fontName: name, size: size)
    }
}
