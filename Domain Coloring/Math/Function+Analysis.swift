//
//  Analysis.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 12/10/22.
//

import Foundation
import Numerics

extension Function {
    
    static func argumentPrinciple(around center: Complex<Double>, radius: Double, precision: Double = 0.001) -> Int {
        
        // this is going to be a really silly way of computing this
        
        let sectorCount = 10
        
        var quadrants = [Bool](repeating: false, count: sectorCount)
        var windingNumber = 0
        
        // 1 if positive direction, -1 if negative direction
        var direction = 1
        
        let sectorWidth = 360.0 / Double(quadrants.count)
        
        for thetaDegrees in 0..<360 {
            let thetaRadians: Double = Double(thetaDegrees) * Double.pi / 180
            let input = center + Complex(radius) * Complex.exp(.i * Complex<Double>(thetaRadians))
            let argument = function(input).angleDegrees
            
            var index = 0
            
            for i in 1...quadrants.count {
                if argument < sectorWidth * Double(i) {
                    index = i - 1
                    break
                }
            }
            
            quadrants[index] = true
            
            // find out what direction we are going!
            let nextIndex = quadrants[(index + 1) % quadrants.count]
            let prevIndex = quadrants[(index + quadrants.count - 1) % quadrants.count]
            
            if nextIndex && !prevIndex {
                direction = -1
            } else if !nextIndex && prevIndex {
                direction = 1
            }
            
            // in other situations, we won't change the direction.
            
            if quadrants.allSatisfy( {$0} ) {
                quadrants = [Bool](repeating: false, count: quadrants.count)
                windingNumber += direction
            }
        }
        
        return windingNumber
        
        
    }
    
}
