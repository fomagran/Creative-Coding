//
//  Zipper.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/08.
//

import UIKit

class Zipper:UIView {
    
    var w:CGFloat = 0
    var h:CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        w = rect.width
        h = rect.height
        let zipper = UIBezierPath(roundedRect: CGRect(x:w/2-17.5, y:0, width: 35, height: 60),cornerRadius: 20)
        UIColor.black.setFill()
        UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1).setStroke()
        zipper.fill()
        zipper.stroke()
        zipper.close()
        
        let smallCircle = UIBezierPath(roundedRect: CGRect(x:w/2-10, y:30, width: 20, height: 20),cornerRadius: 20)
        UIColor.white.setFill()
        UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1).setStroke()
        smallCircle.fill()
        smallCircle.stroke()
        smallCircle.close()
    }
    
}
