// swiftlint:disable all
//
//  Style.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import UIKit

/// A struct to hold a closure that applies styling to a view
/// ```
/// let redStyle = Style({ $0.backgroundColor = .red })
/// redStyle.apply(yourView)
/// ```
///
/// TymeComponent includes common styles:
/// ```
/// Style.destructive.apply(yourView)
/// ```

public struct Style<V> {
    
    public typealias Styler = (V) -> Void

    /// Closure that applies the styling
    public let apply: Styler

    /// Create an Style with a style applier closure
    /// - Parameter : apply The closure that applies the styling
    public init ( _ apply: @escaping Styler) {
        self.apply = apply
    }
    
    /// Call the apply closure as a fuction of the instance.
    public func callAsFunction(apply input: V) {
        apply(input)
    }
    
}

public extension Style {
    /// Compose with multiple styles
    /// - Parameter styles: A list of styles to compose into one
    func compose(_ styles: Style...) -> Style {
        return Style { (v: V) in
            self.apply(v)
            styles.forEach({ $0.apply(v) })
        }
    }
    
    /// Compose with multiple styles
    /// - Parameter superStyles: A list of styles to compose into one
    func compose<W>(_ superStyles: Style<W>...) -> Style<W> {
        return Style<W> { (w: W) in
            guard let v = w as? V else { return }
            self.apply(v)
            superStyles.forEach({ $0.apply(w) })
        }
    }
    
    /// Compose with a styler closure
    /// - Parameter styler: A style closure to compose into one
    func compose(_ styler: @escaping Styler) -> Style {
        return Style { (v: V) in
            self.apply(v)
            styler(v)
        }
    }
    
    /// Compose with a styler closure
    /// - Parameter superStyler: A style closure to compose into one
    func compose<W>(_ superStyler: @escaping (W) -> Void) -> Style<W> {
        return Style<W> {(w: W) in
            guard let v = w as? V else { return }
            
            self.apply(v)
            superStyler(w)
        }
    }

    /// Compose with multiple styles and a styler closure
    /// - Parameter styles: List of styles to compose into one
    /// - Parameter styler: A style closure to compose into one
    func compose(_ styles: Style..., styler: @escaping Styler) -> Style {
        return Style { (v: V) in
            self.apply(v)
            styles.forEach({ $0.apply(v) })
            styler(v)
        }
    }
    
    /// Compose with multiple styles and a styler closure
    /// - Parameter styles: List of styles to compose into one
    /// - Parameter superStyler: A style closure to compose into one
    func compose<W>(_ styles: Style..., superStyler: @escaping (W) -> Void) -> Style<W> {
        return Style<W> { (w: W) in
            guard let v = w as? V else { return }
            self.apply(v)
            styles.forEach({ $0.apply(v) })
            superStyler(w)
        }
    }

    /// Compose with multiple styles and a styler closure
    /// - Parameter superStyles List of styles to compose into one
    /// - Parameter styler: A style closure to compose into one
    func compose<W>(_ superStyles: Style<W>..., styler: @escaping Styler) -> Style<W> {
        return Style<W> { (w: W) in
            guard let v = w as? V else { return }
            self.apply(v)
            superStyles.forEach({ $0.apply(w) })
            styler(v)
        }
    }
    
    /// Compose with multiple styles and a styler closure
    /// - Parameter superStyles: List of styles to compose into one
    /// - Parameter superStyler: A style closure to compose into one
    func compose<W>(_ superStyles: Style<W>..., superStyler: @escaping (W) -> Void) -> Style<W> {
        return Style<W> { (w: W) in
            guard let v = w as? V else { return }
            
            self.apply(v)
            superStyles.forEach({ $0.apply(w) })
            superStyler(w)
        }
    }

}
