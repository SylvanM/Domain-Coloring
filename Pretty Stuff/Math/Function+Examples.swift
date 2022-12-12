//
//  Function+Examples.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 12/11/22.
//

import Foundation
import Numerics

extension Function {
    
    static func makeRationalFunction(withZeros zeros: [Complex<Double>], withPoles poles: [Complex<Double>]) -> (Complex<Double>) -> Complex<Double> {
        { z in
            var product: Complex<Double> = 1
            
            for zero in zeros {
                product *= z - zero
            }
            
            for pole in poles {
                product /= z - pole
            }
            
            return product
        }
    }
    
    // MARK: Example Functions to demonstrate
    
    static func identity(_ z: Complex<Double>) -> Complex<Double> {
        z
    }
    
    static func simpleFifthPower(_ z: Complex<Double>) -> Complex<Double> {
        .pow(z, 5) - 1
    }
    
    static func exampleSimplePole(_ z: Complex<Double>) -> Complex<Double> {
        1 / z
    }
    
    static func finalExamProblem(_ z: Complex<Double>) -> Complex<Double> {
        3 * .exp(z) - z
    }
    
    static func funRationalFunction(_ z: Complex<Double>) -> Complex<Double> {
        makeRationalFunction(withZeros: [
            -1, -1, 5
        ], withPoles: [
            2 * .i, 2 * .i, -3 - .i
        ])(z)
    }
    
}
