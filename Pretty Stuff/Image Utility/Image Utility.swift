//
//  Image Utility.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Foundation
import AppKit
import CoreGraphics

public extension NSImage {
    
    // MARK: Initializer
    
    /**
     * Creates an `NSImage` from pixels
     *
     * - Parameters:
     *      - pixels: An array of pixels represented as 32 bit integers
     *      - width: the width of this image in pixels
     *      - height: the height of this image in pixels
     *
     * - Precondition: `pixels` is of length `width * height`
     */
    convenience init(fromPixels pixels: [UInt32], width: Int, height: Int) {
        
        let size = NSSize(width: width, height: height)
        
        self.init(size: size)
        
        let bitsPerComponent = 8
        let bitsPerPixel = 32
        
        var data = pixels // Copy to mutable array
        
        let providerRef = CGDataProvider(
            data: NSData(bytes: &data, length: data.count * 4)
        )
        
        let cgim = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: width * 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue),
            provider: providerRef!,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        )
        
        self.init(cgImage: cgim!, size: size)
        
    }
    
}

extension NSImageView {
    
    /**
     * Sets the pixels of this image to those that will display a given point array represented by color
     */
    func setPixels(_ pixels: [UInt32]) {
        
        self.image = NSImage(fromPixels: pixels, width: Int(self.bounds.width), height: Int(self.bounds.height))
        
    }
    
    // MARK: Color
    
    /**
     * Converts a vector field to a 2D array of pixels to be displayed
     */
    static func convertToPixels<VectorType: Vector2>(for field: VectorField<VectorType>) -> [UInt32] {
        
        field.vectors.flatMap {
            $0.map { point -> UInt32 in
                let hue = point.angleDegrees
                
                // TODO: Actually calculate the saturation
                let saturation = compress(point.length, max: field.maxLength)
                
                var mid: Double {
                    let inner = (hue / 60).truncatingRemainder(dividingBy: 2)
                    return saturation * (1 - abs(inner - 1))
                }
                
                let m = 1 - saturation
                
                let rgbPrimes: [Double] =
                     hue < 60  ? [saturation, mid, 0] :
                    (hue < 120 ? [mid, saturation, 0] :
                    (hue < 180 ? [0, saturation, mid] :
                    (hue < 240 ? [0, mid, saturation] :
                    (hue < 300 ? [mid, 0, saturation] :
                                 [saturation, 0, mid]))))
                
                var rgba: [UInt8] = [0, 0, 0, UInt8(compress(point.length, max: field.maxLength) * 255)]
                
                for i in 0...2 { rgba[i] = UInt8((rgbPrimes[i] + m) * 255) }
                
                
                return mask(rgba)
            }
        }
        
    }
    
    private static func compress(_ x: Double, max: Double) -> Double {
        
        if ( x.isInfinite ) {
            return 1
        }
        
        if ( x.isNaN ) {
            return 0
        }
        
        return tanh(x)
        
    }
    
    // MARK: Convenience
    
    public static func mask(_ rgba: [UInt8]) -> UInt32 {
        return rgba.withUnsafeBytes {
            $0.bindMemory(to: UInt32.self)
        }.map {
            $0.bigEndian
        }.first!
    }
    
}


