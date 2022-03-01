// swiftlint:disable all
//
//  TymeFont+Named.swift
//  TymeComponent
//
//  Created by Duy Le on 29/11/2021.
//

import Foundation

/// A collection of our preset, named fonts
///
/// A font is defined as a typeface at one specific weight and size (and text stype on iOS)
/// If you want to add color and alignment, see `Typesetting`
public extension BaseFont {
    
    /// Caption, Regular, Small1 (12 pt)
    ///
    /// Used in disclaimer and tracker labels
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Small1 (12pt)
    ///
    /// # UIFont.TextStyle
    /// Caption1
    static let caption = BaseFont.weight(.regular, fontName: BaseFontName.SFProText.rawValue, size: .small1)
    
    /// Footnode, Regular, Small2 (13 pt)
    ///
    /// Used in segment titles
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Small2 (13pt)
    ///
    /// # UIFont.TextStyle
    /// Footnote
    static let footnode = BaseFont.weight(.regular, fontName: BaseFontName.SFProText.rawValue, size: Size.small2)
    
    /// SubHeadline, Regular, Small3 (15 pt)
    ///
    /// Used in sub titles
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Small3 (15pt)
    ///
    /// # UIFont.TextStyle
    /// Footnote
    static let subHeadline = BaseFont.weight(.regular, fontName: BaseFontName.SFProText.rawValue, size: Size.small3)
    
    // MARK: - Bodies
    
    /// Body 1, Regular, Medium1 (17 pt)
    ///
    /// Used in from labels, row titles, hint text, transaction amount, merchant name, and modal titles
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Medium1 (17pt)
    ///
    /// # UIFont.TextStyle
    /// Body
    static let body = BaseFont.weight(.regular, fontName: BaseFontName.SFProText.rawValue, size: .medium1)
    
    // MARK: - Headlines
    
    /// Headline, Semibold, Medium1 (17 pt)
    ///
    /// Used in text links and text buttons.
    ///
    /// # Weight
    /// Semibold
    ///
    /// # Size
    /// Medium1 (17pt)
    ///
    /// # UIFont.TextStyle
    /// Headline
    static let headline = BaseFont.weight(.semiBold, fontName: BaseFontName.SFProDisplay.rawValue, size: Size.medium1.scaled(as: .headline))
    
    // MARK: - Title
    
    /// SmallTitle, Regular, Medium2 (20 pt)
    ///
    /// Used in widget tile titles and transaction section title
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Medium2 (20pt)
    ///
    /// # UIFont.TextStyle
    /// Title3
    static let smallTitle = BaseFont.weight(.regular, fontName: BaseFontName.SFProDisplay.rawValue, size: .medium2)
    
    /// MediumTitle, Regular, Medium3 (28 pt)
    ///
    /// Used in button text (written in sentence case), merchant name transaction detail on L3
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Medium3 (28 pt)
    ///
    /// # UIFont.TextStyle
    /// Title2
    static let mediumTitle = BaseFont.weight(.regular, fontName: BaseFontName.SFProDisplay.rawValue, size: .medium3)
    
    /// LargeTitle, Regular, Large (34 pt)
    ///
    /// Used in hero cent on L1
    ///
    /// # Weight
    /// Regular
    ///
    /// # Size
    /// Large (34 pt)
    ///
    /// # UIFont.TextStyle
    /// LargeTitle
    static let largeTitle = BaseFont.weight(.regular, fontName: BaseFontName.SFProDisplay.rawValue, size: .large)
    
    /// xlargeTitle, Medium, XLarge (50 pt)
    ///
    /// Used in hero cent on L2 and hero cent transaction detail
    ///
    /// # Weight
    /// Light
    ///
    /// # Size
    /// XLarge (50 pt)
    ///
    /// # UIFont.TextStyle
    /// None
    static let xlargeTitle = BaseFont.weight(.medium, fontName: BaseFontName.SFProDisplay.rawValue, size: Size.xlarge.unscaled())
}
