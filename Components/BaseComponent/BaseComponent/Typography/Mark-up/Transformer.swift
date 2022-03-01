//
//  Transformer.swift
//  TymeComponent
//
//  Created by Duy Le on 02/12/2021.
//

import Foundation

/// Transformers take an object of type `A`
/// and return an object of type `Z` transformed
/// with the transform closure
public struct Transformer<A, Z> {
    
    public typealias Transformation = (A) -> Z

    /// A closure to transform A to Z
    private let transform: Transformation

    /// Create a new Transformer
    ///
    /// Used to create an object of type `Z`
    /// based on the input object of type `A`
    ///
    /// - Parameter transform: the closureto create `Z` from `A`
    public init (_ transform: @escaping Transformation) {
        self.transform = transform
    }
    
    /// Call the transform closure as a fuction of the instance.
    ///
    /// - Parameter input: The input object of type A
    /// - Returns : The output object of type `Z`
    public func callAsFunction(transform input: A) -> Z {
        return transform(input)
    }

}

public func +<A, B, C>(lhs: Transformer<A, B>, rhs: Transformer<B, C>) -> Transformer<A, C> {
    .init {
        rhs(transform: lhs(transform: $0))
    }
}
