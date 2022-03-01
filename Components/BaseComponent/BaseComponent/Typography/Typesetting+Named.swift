// swiftlint:disable all
//
//  Typesetting+Named.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import Foundation

/// A collection of preset, named typesettings
public extension Typesetting {
    
    // MARK: - Caption
    
    /// Disclaimer
    ///
    /// Used in disclaimer, tracker labels.
    ///
    /// # Font
    /// Font.caption
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Small1 (12pt)
    ///
    /// ## UIFont.TextStyle
    /// Caption1
    ///
    /// # Color
    /// BaseColor.Denotive.red50 (#DE241D)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let disclaimer = Typesetting(font: BaseFont.caption, color: BaseColor.Denotive.red_50, lineHeightFactor: LineHeightFactor.normal)
    
    /// Caption
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.caption
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Small1 (12pt)
    ///
    /// ## UIFont.TextStyle
    /// Caption1
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let caption = Typesetting(font: BaseFont.caption, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    // MARK: - Footnode
    
    /// Footnode
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.footnode
    ///
    /// ## Weight
    /// SemiBold
    ///
    /// ## Size
    /// Small2 (13pt)
    ///
    /// ## UIFont.TextStyle
    /// Footnote
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let footnode = Typesetting(font: BaseFont.footnode, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    /// SubHeadline
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.subHeadline
    ///
    /// ## Weight
    /// SemiBold
    ///
    /// ## Size
    /// Small3 (15pt)
    ///
    /// ## UIFont.TextStyle
    /// Footnote
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let subHeadline = Typesetting(font: BaseFont.subHeadline, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    // MARK: - Body
    
    /// Body
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.body1
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Medium1 (17pt)
    ///
    /// ## UIFont.TextStyle
    /// Body
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let body = Typesetting(font: BaseFont.body, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    /// Headline
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.link
    ///
    /// ## Weight
    /// SemiBold
    ///
    /// ## Size
    /// Medium1 (17pt)
    ///
    /// ## UIFont.TextStyle
    /// Headline
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let headline = Typesetting(font: BaseFont.headline, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    // MARK: Title
    
    /// SmallTitle
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.smallTitle
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Medium2 (20pt)
    ///
    /// ## UIFont.TextStyle
    /// Title3
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let smallTitle = Typesetting(font: BaseFont.smallTitle, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    /// MediumTitle
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.mediumTitle
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Medium3 (28 pt)
    ///
    /// ## UIFont.TextStyle
    /// Title2
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let mediumTitle = Typesetting(font: BaseFont.mediumTitle, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    /// LargeTitle
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.largeTitle
    ///
    /// ## Weight
    /// Regular
    ///
    /// ## Size
    /// Large (34 pt)
    ///
    /// ## UIFont.TextStyle
    /// Title1
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let largeTitle = Typesetting(font: BaseFont.largeTitle, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
    
    /// XLargeTitle
    ///
    /// Used in (TBD)
    ///
    /// # Font
    /// Font.xlargeTitle
    ///
    /// ## Weight
    /// Medium
    ///
    /// ## Size
    /// xLarge (50 pt)
    ///
    /// ## UIFont.TextStyle
    /// Title1
    ///
    /// # Color
    /// BaseColor.Grey.grey_100 (#000000)
    ///
    /// # Alignment
    /// Left
    ///
    /// # Line Height Factor
    /// Normal (1.5x) - Only respected when using `NSAttributedString`
    static let xlargeTitle = Typesetting(font: BaseFont.xlargeTitle, color: BaseColor.Grey.grey_100, lineHeightFactor: LineHeightFactor.normal)
}
