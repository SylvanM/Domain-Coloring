//
//  Set.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation

/**
 * An object that describes a set of vectors
 */
struct Set<VectorType: Vector2> {
    
    /**
     * A function that checks whether a vector is in the set
     */
    typealias Condition = (VectorType) -> Bool
    
    /**
     * A all the conditions that describe whether a vector is in this set
     */
    private var conditions: [Condition]
    
    /**
     * Returns `true` if a vector is in the set
     *
     * - Parameters:
     *      - vector: A vector to check
     *
     * - Returns: `true` if the vector is in the set
     */
    func contains(_ vector: VectorType) -> Bool {
        conditions.allSatisfy { condition in
            condition(vector)
        }
    }
    
    /**
     * Creates a set just from a set of conditions
     */
    init(conditions: [Condition]) {
        self.conditions = conditions
    }
    
}
