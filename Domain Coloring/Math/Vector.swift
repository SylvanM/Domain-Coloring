//
//  Vector.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation
import CoreGraphics
import Numerics


// MARK: Vector Fields

/**
 * A collection of vectors arranged in a rectangular region of R^2
 */
public struct VectorField<VectorType: Vector2> {
    
    /**
     * All the vectors in this vector field
     *
     * - Invariant: This array will always be rectangular
     */
    var vectors: [[VectorType]]
    
    /**
     * The maximum length of a vector in this field
     *
     * This value will only be altered within this package
     */
    var maxLength: Double
    
    /**
     * The window to view this function
     */
    var window: Function.FunctionWindow
    
    /**
     * The bounds of this vector field when displaying the image
     */
    var bounds: CGRect
    
    /**
     * The width of this vector field
     */
    var width: Int {
        vectors.count
    }
    
    /**
     * The height of this vector field
     */
    var height: Int {
        vectors.first?.count ?? 0
    }
    
    // MARK: Initializers
    
    /**
     * Calculates the vector field of a function over a region
     *
     * - Parameters:
     *      - function: A Function from R^2 to R^2 to graph
     *      - window: Region over which to view the function
     *      - rect: Pixel dimensions of the view
     *      - showMagnitude: Whether or not the magnitude should be taken into account, or just the argument.
     */
    init(forFunction function: Function2<VectorType>, overWindow window: Function.FunctionWindow, forRect rect: CGRect, shouldComputeDeltas: Bool = false) {
        
        self.window = window
        self.bounds = rect
        
        vectors = [[VectorType]](repeating: [VectorType](repeating: VectorType(x1: 0, x2: 0), count: Int(rect.width)), count: Int(rect.height))
        
        maxLength = 0
        
        VectorField.iterate(over: window, vectors: &vectors, forBounds: bounds) { _, input in
            let output = function(input)

            if output.lengthSquared > maxLength {
                maxLength = output.lengthSquared
            }

            return output
        }
        
        maxLength.formSquareRoot()
    }
    
    // MARK: Helper methods
    
    /**
     * Iterates over every point in a window for a pixel rectangle and applies a closure to it
     *
     * - Parameters:
     *      - window: The findow to iterate over
     *      - vectors: `inout` parameter for which vectors to affect
     *      - rect: The pixel dimensions of the window
     *      - closure: Closure to apply to every element in the window
     */
    static func iterate(over window: Function.FunctionWindow, vectors: inout [[VectorType]], forBounds rect: CGRect, closure: (VectorType, VectorType) -> VectorType) {
        
        for y in 0..<vectors.count {
            for x in 0..<vectors[y].count {
                
                let position = VectorType(x1: window.width * Double(x) / Double(vectors.count) + window.horizontal.lowerBound,
                                          x2: window.height * Double(y) / Double(vectors[y].count) + window.vertical.lowerBound)
                
                vectors[y][x] = closure(vectors[y][x], position)
            }
        }
        
    }
    
    // MARK: Methods
    
    /**
     * Adds a set to this vector field, with a given color
     */
    mutating func overlaySet(set: Set<VectorType>, color: CGColor) {
        
        VectorField.iterate(over: window, vectors: &vectors, forBounds: bounds) { vect, position in
            
            if !set.contains(position) {
                return vect
            }
            
            // We need to create a vector that represents the color of our choosing
            
            // TODO Actually make a good color vector thing. For now it'll just be black.
        
            let colorVector = VectorType(x1: 0, x2: 0)
            
            return colorVector
        }
        
    }
    
}

// MARK: Vector2

/**
 * An object that can be represented as a vector in R^2
 */
public protocol Vector2 {
    
    /**
     * The first component of this point
     */
    var x1: Double { get set }
    
    /**
     * The second component of this point
     */
    var x2: Double { get set }
    
    /**
     * The length of this vector squared
     */
    var lengthSquared: Double { get }
    
    /**
     * The length, or magnitude of this vector
     */
    var length: Double { get }
    
    /**
     * The angle this vector makes with the `x1` axis in radians
     */
    var angleRadians: Double { get }
    
    /**
     * The angle this vector makes with the `x1` axis in degrees
     */
    var angleDegrees: Double { get }
    
    /**
     * Creates a vector from components
     *
     * - Parameters:
     *      - x1: The `x1` component
     *      - x2: The `x2` component
     */
    init(x1: Double, x2: Double)
    
}

public extension Vector2 {
    
    var lengthSquared: Double {
        pow(x1, 2) + pow(x2, 2)
    }
    
    var length: Double {
        lengthSquared.squareRoot()
    }
    
    var angleRadians: Double {
        
        /*
         * Return values:
         *  - 0: negative infinity
         *  - 1: finite
         *  - 2: positive infinity
         */
        func compareToInfinity(_ a: CGFloat) -> Int {
            
            if a.isFinite { return 1 }
            
            return a < 0 ? 0 : 2
            
        }
        
        // If any of the coordinates are infinite, we have to do some checking ourselves
        if !(self.x1.isFinite && self.x2.isFinite) {
            let angles: [[Double]] = [
                [225,   180,    135],
                [270,    -1,     90],
                [315,     0,     45]
            ]
            
            return angles[compareToInfinity(CGFloat(self.x1))][compareToInfinity(CGFloat(self.x2))]
        }
        
        var radians = Double(atan2(self.x2, self.x1))
    
        while radians < 0 {
            radians += Double(2 * Double.pi)
        }
        
        return radians
    }
    
    var angleDegrees: Double {
        angleRadians * 180 / Double.pi
    }
    
}

extension CGPoint: Vector2 {
    
    public var x1: Double {
        get { Double(self.x) }
        set { self.x = CGFloat(newValue) }
    }
    
    public var x2: Double {
        get { Double(self.y) }
        set { self.y = CGFloat(newValue) }
    }
    
    public init(x1: Double, x2: Double) {
        self.init(x: CGFloat(x1), y: CGFloat(x2))
    }
    
}

extension Complex: Vector2 where RealType == Double {
    
    public var x1: Double {
        get { self.real }
        set { self.real = newValue }
    }
    
    public var x2: Double {
        get { self.imaginary }
        set { self.imaginary = newValue }
    }
    
    public init(x1: Double, x2: Double) {
        self.init(x1, x2)
    }

}

// MARK: Functions

/**
 * A function mapping R^2 to R^2
 */
typealias Function2<VectorType: Vector2> = (VectorType) -> VectorType



