//
//  Axes.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation

extension Set {
    
    /**
     * Creates a line representing the horizontal axis
     *
     * - Parameters:
     *      - width: Width of the axis
     */
    static func horizontalAxis(width: Double = 0, withTicks: Bool = true) -> Set {
        
        let lineCondition: (VectorType) -> Bool = { vect in
            return abs(vect.x2) <= width
        }
        
        var conditions = [lineCondition]
        
        if withTicks {
            conditions.append { vect in
                (abs(vect.x2) <= width * 15) &&
                abs(Double(Int(vect.x1)) - vect.x1) <= width
            }
        }
        
        let orConds: (VectorType) -> Bool = { vect in
            conditions.contains { $0(vect) }
        }
        
        return Set(conditions: [orConds])
        
    }
    
    /**
     * Creates a line representing the vertical axis
     *
     * - Parameters:
     *      - width: Width of the axis
     */
    static func verticalAxis(width: Double = 0, withTicks: Bool = true) -> Set {
        let lineCondition: (VectorType) -> Bool = { vect in
            return abs(vect.x1) <= width
        }
        
        var conditions = [lineCondition]
        
        if withTicks {
            conditions.append { vect in
                (abs(vect.x1) <= width * 15) &&
                abs(Double(Int(vect.x2)) - vect.x2) <= width
            }
        }
        
        let orConds: (VectorType) -> Bool = { vect in
            conditions.contains { $0(vect) }
        }
        
        return Set(conditions: [orConds])
    }
    
}
