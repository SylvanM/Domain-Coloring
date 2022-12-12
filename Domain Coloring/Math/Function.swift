//
//  Function.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation
import Numerics

// MARK: Function definition
 
/**
 * Static structure that defines the function to be used in this whole application
 */
public struct Function {
    
    // MARK: Type Descriptions
    
    /**
     * The type of vector used for this functoin
     */
    typealias VectorType = Complex<Double>
//    typealias VectorType = CGPoint
    
    /**
     * A struct representing the rectangular window over which to view this function
     */
    struct FunctionWindow {
        
        /**
         * The horizontal bounds
         */
        var horizontal: ClosedRange<Double>
        
        /**
         * The vertical bounds
         */
        var vertical: ClosedRange<Double>
        
        /**
         * The width of this window
         */
        var width: Double {
            vertical.upperBound - vertical.lowerBound
        }
        
        /**
         * The height of this window
         */
        var height: Double {
            horizontal.upperBound - horizontal.lowerBound
        }
        
        /**
         * The aspect ratio of this window
         */
        var aspectRatio: Double {
            return width / height
        }
        
        func shifted(horizontalShift horizontalAmount: Double, verticalShift verticalAmount: Double) -> FunctionWindow {
            FunctionWindow(
                horizontal: (horizontal.lowerBound + horizontalAmount)...(horizontal.upperBound + horizontalAmount),
                vertical: (vertical.lowerBound + verticalAmount)...(vertical.upperBound + verticalAmount)
            )
        }
        
        func scaled(horizontal horizAmount: Double, vertical vertiAmount: Double) -> FunctionWindow {
            FunctionWindow(
                horizontal: (horizontal.lowerBound * horizAmount)...(horizontal.upperBound * horizAmount),
                vertical: (vertical.lowerBound * vertiAmount)...(vertical.upperBound * vertiAmount)
            )
        }
        
    }
    
    // MARK: Static Definitions
    
    /**
     * The window for this graph to be visualized
     */
    static let window = FunctionWindow(
        horizontal: -1.5...1.5,
        vertical: -1.5...1.5
    )
    
    /**
     * The function to be visualized by this application
     */
    static func function(_ z: VectorType) -> VectorType {
//        identity(z)
//        simpleFifthPower(z)
//        exampleSimplePole(z)
        finalExamProblem(z)
//        funRationalFunction(z)
//        1 / (z * z)
    }
    
    
    
}

