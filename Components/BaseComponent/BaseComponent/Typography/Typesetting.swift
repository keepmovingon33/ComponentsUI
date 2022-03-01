// swiftlint:disable all
//
//
//  Typesetting.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import UIKit

/// A combination of font, color, alighment, and line height to apple to a label
public struct Typesetting {
    
    /// The font applied to the text
    public let font: UIFont
    
    /// The color applied to the text
    public let color: UIColor
    
    /// The alignment applied to the text
    public let alignment: NSTextAlignment
    
    /// The factor applied to the font's point size when using attributed text
    ///
    /// This is set on an `NSParagraphStyle` applied to an `NSAttributedString`
    ///
    /// #Note
    /// This will only be respected if text is set with `NSAttributedString`
    /// UILabel and UITextView don't have direct accessors to modify the line height.
    ///
    /// #Explaination
    /// The differences between "line height" and "line spacing" can be confusing
    ///
    /// Fonts have a constant natural `lineHeight`, which is multiplied by `lineHeightMultiple` to create the paragraph's line height
    /// That is then clamped by the minimum and maximum line heights, and an additional `lineSpacing` is applied to calculate the final line height:
    ///
    ///     multipliedLineHeight = font.lineHeight * paragraphStyle.lineHeightMultiple
    ///     lineHeight = max(paragraphStyle.minimumLineHeight, min(multipliedLineHeight, paragraphStyle.maximumLineHeight)) + paragraphStyle.lineSpacing
    ///
    /// Setting `paragraphStyle.lineHeightMultiple` will modify the top inset of the view and throw off our frame
    /// So we actually set `paragraphStyle.lineSpacing` by calculating it ourselves. Although, if our desired `lineHeight` is less
    /// Than the font's natural line height (`lineSpacing` cannot be negative), we set the `paragraphStyle.lineHeightMultiple`
    ///
    /// See `lineHeight` and `paragraphStyle` below
    public let lineHeightFactor: CGFloat
    
    /// The amount to multiple by the font size to set the spacing between paragraphs
    /// The result will be evenly split between NSParagraphStyle's `paragraphSpacing` and `paragraphSpacingBefore`
    /// Defaults to 1
    public let paragraphSpacingFactor: CGFloat
    
    // MARK: -
    
    /// The type used by `NSAttributedString` attributes
    public typealias Attributes = [NSAttributedString.Key: Any]
    
    /// Computed paragraph style to apply when using attributed text
    public let paragraphStyle: NSParagraphStyle
    
    /// Calculated line spacing from the font's point size and our line height factor
    public let lineHeight: CGFloat
    
    /// Calculated paragraph spacing (`paragraphSpacingFactor` x `font.pointSize`)
    public let paragraphSpacing: CGFloat
    
    /// Computed attributes to apply to attributed text
    public let attributes: Attributes
    
    /// Computed attributes appended with additional attributes to apple to attributed text
    public func attributes(appending dictionary: Attributes) -> Attributes {
        attributes.merging(dictionary, uniquingKeysWith: { $1 })
    }
    
    // MARK: -
    
    public init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .left, lineHeightFactor: CGFloat, paragraphSpacingFactor: CGFloat = 1) {
        self.font = font
        self.color = color
        self.alignment = alignment
        
        self.lineHeightFactor = lineHeightFactor
        self.lineHeight = font.pointSize * lineHeightFactor
        
        self.paragraphSpacingFactor = paragraphSpacingFactor
        self.paragraphSpacing = font.pointSize * paragraphSpacingFactor
        
        let mutalbleParagraphStyle = NSMutableParagraphStyle()
        mutalbleParagraphStyle.alignment = alignment
        mutalbleParagraphStyle.maximumLineHeight = 0
        mutalbleParagraphStyle.paragraphSpacing = self.paragraphSpacing / 2
        mutalbleParagraphStyle.paragraphSpacingBefore = self.paragraphSpacing / 2
        
        let lineSpacing = self.lineHeight - font.lineHeight
        let lineHeightMultiple = self.lineHeight / font.lineHeight
        
        /// NOTE: Modifying `lineHeightMultiple` will cause UIKit to
        /// add padding to the top of the view. `lineSpacing` only
        /// adds spacing between lines, but always has to be positive
        if lineHeight >= 0 {
            mutalbleParagraphStyle.lineSpacing = lineSpacing
            mutalbleParagraphStyle.lineHeightMultiple = 0
        } else {
            mutalbleParagraphStyle.lineSpacing = 0
            mutalbleParagraphStyle.lineHeightMultiple = lineHeightMultiple
        }
        
        self.paragraphStyle = mutalbleParagraphStyle as NSParagraphStyle
        
        self.attributes = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
    }
    
    internal init(font: UIFont, color: UIColor, paragraphStyle: NSParagraphStyle) {
        self.font = font
        self.color = color
        self.alignment = paragraphStyle.alignment
        
        if paragraphStyle.lineSpacing > 0 {
            self.lineHeightFactor = (paragraphStyle.lineSpacing + font.lineHeight) / font.pointSize
        } else {
            self.lineHeightFactor = (paragraphStyle.lineHeightMultiple * font.lineHeight) / font.pointSize
        }
        
        self.lineHeight = font.pointSize * self.lineHeightFactor
        
        self.paragraphSpacing = paragraphStyle.paragraphSpacing + paragraphStyle.paragraphSpacingBefore
        self.paragraphSpacingFactor = self.paragraphSpacing / font.pointSize
        
        self.paragraphStyle = paragraphStyle
        
        self.attributes = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
    }
    
    /// Returns a new Typesetting with the same attributes, replacing the spacificied attributes
    internal func copy(font: UIFont? = nil,
                       color: UIColor? = nil,
                       alignment: NSTextAlignment? = nil,
                       lineHeightFactor: CGFloat? = nil,
                       paragraphSpacingFactor: CGFloat? = nil) -> Typesetting {
        return Typesetting(font: font ?? self.font,
                           color: color ?? self.color,
                           alignment: alignment ?? self.alignment,
                           lineHeightFactor: lineHeightFactor ?? self.lineHeightFactor,
                           paragraphSpacingFactor: paragraphSpacingFactor ?? self.paragraphSpacingFactor)
    }
    
    // MARK: -
    
    /// Returns a semibold version of the Typesetting. If the font is already semibold or bold, it returns a bold version
    public var strong: Typesetting {
        return copy(font: font.strong)
    }
    
    /// Returns a light version of the Typesetting. If the font is already light or extra light, it returns a extra light version
    public var weak: Typesetting {
        return copy(font: font.weak)
    }
    
    /// Returns an overlay that will recolor the Typesetting to white
    public var overlay: Typesetting {
        return copy(color: .white)
    }
    
    /// Returns an italic version of the Typesetting
    public var emphasics: Typesetting {
        return copy(font: font.emphasis)
    }
    
    /// Returns a center-aligned version of the Typesetting
    public var centered: Typesetting {
        return copy(alignment: .center)
    }
    
    /// Returns a differently weighted Typesetting at the same size and text style
    public func at(weight: BaseFont.Weight) -> Typesetting {
        return copy(font: font.at(weight: weight))
    }
    
    /// Returns a differently sized Typesetting at the same weight and text style
    public func at(size: BaseFont.Size) -> Typesetting {
        return copy(font: font.at(size: size))
    }
    
    /// Returns a differently color Typesetting at the same weight and text style
    public func at(color: UIColor) -> Typesetting {
        return copy(color: color)
    }
    
    /// Returns a differently weighted Typesetting at the same size and text style
    public func at(alignment: NSTextAlignment) -> Typesetting {
        return copy(alignment: alignment)
    }
    
    // MARK: -
    
    /// Returns a modified Typesetting suited to lay-put an indented list.
    ///
    /// To create a list, prepend each paragraph with the bullet string (ex. ".") followed by a tab ("\t");
    ///
    /// ```
    /// let listString = "•\tItem"
    /// one\(Typesetting.Separator.paragraph)•\tItem
    /// two\(Typesetting.Separator.paragraph)•\tItem three"
    /// ```
    ///
    /// If you want an un-bulleted paragraph, separated by `Typesetting.Separator.paragraph`, you must still prepend a tab to maintain the left alignment.
    /// although, lines separated by `Typesetting.Sperarator.line` do not need tab characters to align, but cannot contain bullets. To keep list items from using paragraph spacing, set `separateParagraphs` to `false`
    ///
    /// - Parameters:
    ///     - bulletStrong: The charactor string to use as a list bullet. Defaults to "."
    ///     - separateParagraphs: whether or not paragraphs maintain `paragraphSpacing`. Defaults to `true`
    /// - Returns: A new Typesetting indented for a list
    public func list(with bulletString: String = "•", separateParagraphs: Bool = true) -> Typesetting {
        guard let mutableParagraphStyle = paragraphStyle.mutableCopy() as? NSMutableParagraphStyle else {
            return self
        }
        
        let indent: CGFloat = NSAttributedString(string: bulletString, attributes: [.font: font]).size().width + 0
        mutableParagraphStyle.headIndent = indent
        mutableParagraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: indent)]
        
        mutableParagraphStyle.paragraphSpacing = separateParagraphs ? mutableParagraphStyle.paragraphSpacing : 0
        mutableParagraphStyle.paragraphSpacingBefore = separateParagraphs ? mutableParagraphStyle.paragraphSpacingBefore : 0
        
        return Typesetting(font: font, color: color, paragraphStyle: mutableParagraphStyle as NSParagraphStyle)
    }
    
    /// Returns a modified Typesetting suited to lay-put a number list.
    ///
    /// To create a list, prepend each paragraph with the bullet string (ex. ".") followed by a tab ("\t");
    ///
    /// ```
    /// let listString = "1.\tItem"
    /// one\(Typesetting.Separator.paragraph)2.\tItem
    /// two\(Typesetting.Separator.paragraph)3.\tItem three"
    /// ```
    ///
    /// If you want an un-bulleted paragraph, separated by `Typesetting.Separator.paragraph`, you must still prepend a tab to maintain the left alignment.
    /// although, lines separated by `Typesetting.Sperarator.line` do not need tab characters to align, but cannot contain bullets. To keep list items from using paragraph spacing, set `separateParagraphs` to `false`
    ///
    /// - Parameters:
    ///     - numberedRange: The charactor string to use as a number list. ex: 0...4
    ///     - separateParagraphs: whether or not paragraphs maintain `paragraphSpacing`. Defaults to `true`
    /// - Returns: A new Typesetting indented for a list
    public func list(with numberedRange: ClosedRange<Int>, separateParagraphs: Bool = true) -> Typesetting {
        let widestElement = numberedRange.max(by: { (a, b) in
            NSAttributedString(string: String(a), attributes: [.font: font]).size().width > NSAttributedString(string: String(b), attributes: [.font: font]).size().width
        })
        
        if let widestElement = widestElement {
            return list(with: String(widestElement), separateParagraphs: separateParagraphs)
        } else {
            return self
        }
    }
}
