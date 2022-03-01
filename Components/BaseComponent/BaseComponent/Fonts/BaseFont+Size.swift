//
//  TymeFont+Size.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import UIKit

extension BaseFont {
    public struct Size: Hashable, Equatable, RawRepresentable {
        /// The raw point value size
        public let rawValue: CGFloat
        
        /// The text style to use for Dynamic Type
        /// If nil, the size will not scale
        public let style: UIFont.TextStyle?
        
        public init(rawValue: CGFloat) {
            self.rawValue = rawValue
            self.style = nil
        }
        
        public init(_ rawValue: CGFloat, style: UIFont.TextStyle?) {
            self.rawValue = rawValue
            self.style = style
        }
        
        // MARK: - Constants
        
        /// 12 pt, caption1
        ///
        /// # Size
        /// 12 pt
        ///
        /// # UIFont.TextStyle
        /// caption1
        public static let small1 = scaled(12, style: .caption1)
        
        /// 13 pt, footnote
        ///
        /// # Size
        /// 13 pt
        ///
        /// # UIFont.TextStyle
        /// footnote
        public static let small2 = scaled(13, style: .footnote)
        
        /// 15 pt, subheadline
        ///
        /// # Size
        /// 15 pt
        ///
        /// # UIFont.TextStyle
        /// subheadline
        public static let small3 = scaled(15, style: .subheadline)
        
        /// 17 pt, body
        ///
        /// # Size
        /// 17 pt
        ///
        /// # UIFont.TextStyle
        /// body
        public static let medium1 = scaled(17, style: .body)
        
        /// 20 pt, title3
        ///
        /// # Size
        /// 20 pt
        ///
        /// # UIFont.TextStyle
        /// title3
        public static let medium2 = scaled(20, style: .title3)
        
        /// 28 pt, title2
        ///
        /// # Size
        /// 28 pt
        ///
        /// # UIFont.TextStyle
        /// title2
        public static let medium3 = scaled(28, style: .title2)
        
        /// 34 pt, title1
        ///
        /// # Size
        /// 34 pt
        ///
        /// # UIFont.TextStyle
        /// title1
        public static let large = scaled(34, style: .title1)
        
        /// 50 pt, largeTitle
        ///
        /// # Size
        /// 50 pt
        ///
        /// # UIFont.TextStyle
        /// title1
        public static let xlarge = scaled(50, style: .title1)
        
        // MARK: -
        
        /// Returns a dynamic font size that will scale with Dynamic Type according to the style
        public static func scaled(_ value: CGFloat, style: UIFont.TextStyle) -> Size {
            return Size(value, style: style)
        }
        
        /// Returns a dynamic font size that will scale Dynamic Type according to the best guess style:
        /// - Up through 12 pt: Cation 1
        /// - Up through 13 pt: Footnode
        /// - Up through 15 pt: Subheadline
        /// - Up through 17 pt: Body
        /// - Up through 20 pt: Title 3
        /// - Up through 28 pt: Title 2
        /// - Up through 34 pt: Title 1
        /// - Otherwise: Large Title
        public static func scaled(_ value: CGFloat) -> Size {
            let style: UIFont.TextStyle
            
            switch value {
            case ...12:
                style = .caption1
            case ...13:
                style = .footnote
            case ...15:
                style = .subheadline
            case ...17:
                style = .body
            case ...20:
                style = .title3
            case ...28:
                style = .title2
            case ...34:
                style = .title1
            default:
                style = .title1
            }
            
            return Size(value, style: style)
        }
        
        /// Returns a static font size that won't scale with Dynamic Type
        public static func exactly(_ value: CGFloat) -> Size {
            return Size(value, style: nil)
        }
        
        // MARK: -
        
        /// Returns a new Size with a different UIFont.TextStyle
        public func scaled(as stype: UIFont.TextStyle) -> Size {
            return Size(rawValue, style: style)
        }
        
        /// Returns a new Size without a UIFont.TextStyle
        public func unscaled() -> Size {
            return Size(rawValue, style: nil)
        }
    }
}
