// swiftlint:disable all
//
//
//  Style+UILabel.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import UIKit

public extension UILabel {
    /// Initialize this class and immediately apply the UILabel style
    /// - Parameter style: The UlLabel style to apply
    convenience init(style: Style<UILabel>) {
        self.init()
        style.apply(self)
    }

    /// Apply the UILabel style to this view
    /// - Parameter style: The UILabel style to apply
    @discardableResult func style(as style: Style<UILabel>) -> Self {
        style.apply(self)
        return self
    }
    
    // MARK: -
    /// Initialize this class and immediately apply the Typesetting style
    ///
    /// - Parameters:
    ///  - style: The Typesetting style to apply
    ///  - backgroundStyle: The style to apply to the view, serving as the background color.
    /// Use `.base` for arav backgrounds `.raised` for white. Defaults to `.base`
    convenience init(style: Typesetting, on backgroundStyle: Style<UIView>? = nil) {
        self.init()
        
        Style<UILabel>.typesetting(style).apply(self)
        backgroundStyle?.apply(self)
    }
    
    /// Apply the Typesetting style to this view
    ///
    /// - Parameters:
    ///  - style: The Typesetting style to apply
    ///  - backgroundStyle: The style to apply to the view, serving as the background color.
    /// Use `.base` for arav backgrounds `.raised` for white. Defaults to `.base`
    @discardableResult func style(as style: Typesetting, on backgroundStyle: Style<UIView>? = nil) -> Self {
        Style<UILabel>.typesetting(style).apply(self)
        backgroundStyle?.apply(self)
        
        return self
    }
}

public extension Style where V: UILabel {
    static var unformatted: Style<UILabel> {
        return .init { (label: UILabel) in
            label.adjustsFontForContentSizeCategory = true
            label.adjustsFontSizeToFitWidth = true
            label.allowsDefaultTighteningForTruncation = true
            label.baselineAdjustment = .alignBaselines
            label.lineBreakMode = .byWordWrapping
            label.minimumScaleFactor = 0.5
            label.numberOfLines = 0
            label.textAlignment = .left
            label.backgroundColor = .clear
        }
    }

    static func typesetting(_ typesetting: Typesetting) -> Style<UILabel> {
        return unformatted.compose { (label: UILabel) in
            label.font = typesetting.font
            label.textColor = typesetting.color
            label.textAlignment = typesetting.alignment
        }
    }
}
