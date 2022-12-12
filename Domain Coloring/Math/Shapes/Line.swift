//
//  Line.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation

/**
 * Set representing a line in R^2
 */
extension Set {
    
    /**
     * Creates a line from two vectors, the span vector and offset vector
     *
     * - Parameters:
     *      - span: vector that describes the span of the line
     *      - offset: vector that translates the span
     *      - width: width of the line
     */
    static func vectorSpanLine(spanVector span: VectorType, offset: VectorType, width: Double = 0) -> Set {
        
        let distanceCondition: Condition = { vect in
            
            let translated = VectorType(x1: vect.x1 - offset.x1, x2: vect.x2 - offset.x2)
            
            // First, check if the point is at least ON the line
            if translated.angleRadians == span.angleRadians {
                return true
            }
            
            // find when the dot product of translated and span equals zero, then use
            // distance formula on that point
            let parameter = (span.lengthSquared) / (span.x1 * translated.x1 + span.x2 * translated.x2)
            
            // now find the distance between span * parameter and the origin
            let distance = VectorType(x1: span.x1 * parameter, x2: span.x2 * parameter).length
            
            return distance <= width
        }
        
        return Set<VectorType>(conditions: [distanceCondition])
    }
    
    // MARK: Static Functions
    
    /**
     * Creates a line of the form `y = mx + b`
     *
     * - Parameters:
     *      - m: Slope of the line
     *      - b: y-intercept of the line
     *      - width: width of the line
     *
     * - Returns: A `Line` representing the linear line
     */
    static func slopeIntercept(slope m: Double, intercept b: Double, width: Double = 0) -> Set {
        return Set<VectorType>.vectorSpanLine(spanVector: VectorType(x1: 1, x2: m), offset: VectorType(x1: 0, x2: b), width: width)
    }
    
}

