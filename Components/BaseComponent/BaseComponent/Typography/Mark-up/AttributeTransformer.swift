// swiftlint:disable all
//
//  AttributeTransformer.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import UIKit
import Foundation

/// A type to transform NSAttributedString attributes
public typealias AttributeTransformer = Transformer<[NSAttributedString.Key: Any], [NSAttributedString.Key: Any]>

/// A set of attribute transformations
public extension AttributeTransformer {
    
    /// Return an empty attribute dictionary
    static let empty: Self = .init ({ _ in [:] })
    
    // MARK: -

    /// Return the input Key. font attribute as semi-bold
     static let strong: Self = .init { [.font: ($0[.font] as? UIFont)?.strong as Any] }
    
    /// Return the input Key. font attribute as light
    static let weak: Self = .init { [.font: ($0[.font] as? UIFont)?.weak as Any] }
    
    /// Return the input Key. font attribute as italic
    static let emphasis: Self = .init { [.font: ($0[.font] as? UIFont)?.emphasis as Any] }

    // MARK: -
    /// Return a dictionary of attributes marked with:
    /// - `Key.link` set to the url parameter
    /// - `Key.font` converting the input font as semi-bold
    /// - `Key.foregroundColor` set to `BaseColor.Grey.grey_100`
    ///
    /// - Parameter url: The URL to link to
    /// - Returns: The new attributes
    static func link(url: URL) -> Self {
        .init {[
            .link: url,
            .font: ($0[.font] as? UIFont)?.strong as Any,
            .foregroundColor: BaseColor.Grey.grey_100,
        ]}
    }
    
    /// Return a dictionary of attributes marked with:
    /// - `Key.link` set to the phoneNumber parameter, appended with "tel:"
    /// - `Key.font` converting the input font as semi-bold
    /// - `Key.foregroundColor` set to `BaseColor.Grey.grey_100`
    ///
    /// - Parameter phoneNumber: The phone number to link to
    /// - Returns: The new attributes
    static func link (phoneNumber: String) -> Self {
        return URL(string: "tel:" + phoneNumber).map(link(url: )) ?? . empty
    }

    // MARK: -
    
    /// Return `Key.accessibilitySpeechSpellOut` set to true to spell out each letter
    @available(iOS 13.0, *)
    static let spellOut: Self = .init{ _ in [.accessibilitySpeechSpellOut: true] }
    
    /// Return Key. accessibilitySpeechIPANotation set to ipaString to augment the pronunciation of the marked text with its IPA notation https://en.wikipedia.org/wiki/Phonetic_symbols_in_Unicode
    @available(iOS 11.0, *)
    static func ipa(string ipaString: String) -> Self { .init { _ in [.accessibilitySpeechIPANotation: ipaString] } }
}
