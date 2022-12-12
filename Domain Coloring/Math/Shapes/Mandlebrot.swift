//
//  Mandlebrot.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation
import Numerics

/**
 * The mandlebrot set
 */
extension Set {
    
    /**
     * Creates a set that represents the fractal Mandlebrot set. This will work on vectors as well as complex numbers,
     * but the components of the vector will be treated as the real and imaginary components of a complex number.
     */
    static func mandlebrot(maxIterations: Int = 100) -> Set {
        
        func mandlebrot(_ c: Complex<Double>) -> Int {
            var z: Complex<Double> = 0
            var n = 0
            
            while z.length <= 2 && n < maxIterations {
                z = z * z + c
                n += 1
            }
            
            return n
        }
        
        let condition: (VectorType) -> Bool = { vect in
            mandlebrot(Complex<Double>(x1: vect.x1, x2: vect.x2)) == maxIterations
        }
        
        return Set(conditions: [condition])
        
    }
    
}

