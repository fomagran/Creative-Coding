//
//  ZipperTop.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/08.
//

import UIKit

class ZipperTop:UIView {
    var w:CGFloat = 0
    var h:CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        w = rect.width
        h = rect.height
        
        let top = UIBezierPath(roundedRect: CGRect(x:w/2-5, y:0, width: 10, height: 40),cornerRadius: 20)
        UIColor.white.setFill()
        UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1).setStroke()
        top.fill()
        top.stroke()
        top.close()
    }
}
