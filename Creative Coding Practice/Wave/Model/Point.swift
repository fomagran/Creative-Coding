//
//  Point.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/04.
//

import Foundation

struct Point {
    var x:CGFloat
    var y:CGFloat
    var max:CGFloat
    var min:CGFloat
    var addY:CGFloat
    var center:CGPoint {
        return CGPoint(x: x, y: y)
    }
}
