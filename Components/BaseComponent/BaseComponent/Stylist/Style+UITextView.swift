// swiftlint:disable all
//
//  Style+UITextView.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import UIKit

public extension UITextView {
    
    /// Initialize this class and immediately apply the UITextView style
    /// - Parameter style: The UITextView style to apply
    convenience init(style: Style<UITextView>) {
        self.init()
        style.apply(self)
    }

    /// Apply the UITextView style to this view
    /// - Parameter style: The UITextView style to apply
    @discardableResult func style(as style: Style<UITextView>) -> Self {
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
        
        Style<UITextView>.typesetting(style).apply(self)
        backgroundStyle?.apply(self)
    }
    
    /// Apply the Typesetting style to this view
    ///
    /// - Parameters:
    ///  - style: The Typesetting style to apply
    ///  - backgroundStyle: The style to apply to the view, serving as the background color.
    /// Use `.base` for arav backgrounds `.raised` for white. Defaults to `.base`
    @discardableResult func style(as style: Typesetting, on backgroundStyle: Style<UIView>? = nil) -> Self {
        Style<UITextView>.typesetting(style).apply(self)
        backgroundStyle?.apply(self)
        
        return self
    }
}

public extension Style where V: UITextView {
    static var unformatted: Style<UITextView> {
        return .init { (textView: UITextView) in
            textView.adjustsFontForContentSizeCategory = true
            textView.allowsEditingTextAttributes = false
            textView.dataDetectorTypes = []
            textView.isEditable = false
            textView.isSelectable = false
            textView.isUserInteractionEnabled = false
            textView.isScrollEnabled = false
            textView.textContainerInset = .zero
            textView.textContainer.lineFragmentPadding = 0
            textView.textContainer.lineBreakMode = .byWordWrapping
            textView.contentInset = .zero
            textView.textAlignment = .left
            textView.backgroundColor = .clear
        }
    }

    static func typesetting(_ typesetting: Typesetting) -> Style<UITextView> {
        return unformatted.compose { (textView: UITextView) in
            textView.font = typesetting.font
            textView.textColor = typesetting.color
            textView.textAlignment = typesetting.alignment
        }
    }
}
