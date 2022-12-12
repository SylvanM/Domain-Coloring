//
//  Complex Arithmetic.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation
import Numerics

extension Complex where RealType == Double {
    
    public var inverse: Complex<RealType> {
        self.conjugate / Complex(Double.pow(self.magnitude, 2))
    }
    
}
