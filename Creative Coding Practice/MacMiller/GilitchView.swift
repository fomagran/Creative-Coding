//
//  GilitchView.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/21.
//

import Foundation
import UIKit

class GlitchView:UIView {
    
    var image = UIImage(named:"macmiller")!.flipImageVertically()!.cgImage!
    
    override func draw(_ rect: CGRect) {
        // Create decode array, flipping alpha channel
        let decode = [ CGFloat(1), CGFloat(0),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1),
                       CGFloat(0), CGFloat(1) ]
        
        // Create the mask `CGImage` by reusing the existing image data
        // but applying a custom decode array.
        let mask =  CGImage(width:              image.width,
                            height:             image.height,
                            bitsPerComponent:   image.bitsPerComponent,
                            bitsPerPixel:       image.bitsPerPixel,
                            bytesPerRow:        image.bytesPerRow,
                            space:              image.colorSpace!,
                            bitmapInfo:         image.bitmapInfo,
                            provider:           image.dataProvider!,
                            decode:             decode,
                            shouldInterpolate:  image.shouldInterpolate,
                            intent:             image.renderingIntent)
        
        let context = UIGraphicsGetCurrentContext()!
        
        // paint solid green background to highlight the transparent areas
        context.setFillColor(UIColor.green.cgColor)
        context.fill(rect)
        
        // render the mask image directly. The black areas will be masked.
        context.draw(mask!, in: rect)
        
        // Clip to the mask image
        context.clip(to: rect, mask: mask!)
        
        // Create a simple linear gradient
        let colors = [ UIColor.systemRed.cgColor, UIColor.systemRed.cgColor, UIColor.systemRed.cgColor ]
        let gradient = CGGradient(colorsSpace: context.colorSpace, colors: colors as CFArray, locations: nil)
        
        // Draw the linear gradient around the clipping area
        context.drawLinearGradient(gradient!,
                                   start: CGPoint.zero,
                                   end: CGPoint(x: rect.size.width, y: rect.size.height),
                                   options: CGGradientDrawingOptions())
    }
}
