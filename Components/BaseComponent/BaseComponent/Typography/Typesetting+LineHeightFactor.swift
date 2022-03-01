// swiftlint:disable all
//
//  Typesetting+LineHeightFactor.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import CoreGraphics

extension Typesetting {
    
    public enum LineHeightFactor {
        /// 1.2x
        public static let tiny: CGFloat = 1.2
        
        /// 1.3x
        public static let small: CGFloat = 1.3
        
        /// 1.5x
        public static let normal: CGFloat = 1.5
        
        /// 1.7x
        public static let medium: CGFloat = 1.7
    }
    
    public enum Separator {
        /// Unicode charactor "Line Separator", U+2028
        ///
        /// Using this charactor will create a new line, but maintain the line spacing of normally wrapped text.
        ///
        /// To create a new paragraph, use `Typesetting.Separator.paragraph`
        public static let line: String = "\u{2028}"
        
        /// Unicode charactor "Paragraph Separator", U+2029
        ///
        /// Using this charactor will create a new paragraph, which will add the amount of `paragraphSpacing` between the two lines of text
        ///
        /// Using `\n` will have the same effect.
        ///
        /// #Note
        /// Do not use two consecutive `\n\n` to create a new paragraph, that will add an empty new line and throw off our measurements.
        public static let paragraph: String = "\u{2029}"
        
        /// Unicode charactor "No Break Space", U+00a0
        ///
        /// Using this charactor will prevent an automatic line break at its position and instead the line will break at the previous space character
        public static let noBreakSpace: String = "\u{00a0}"
    }
}
