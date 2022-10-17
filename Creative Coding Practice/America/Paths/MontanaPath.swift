//
//  MontanaPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let montanaPath = {
    let width:CGFloat = 400
    let height:CGFloat = 200

    let easierPath = EasierPath(0,0)
        .down(height/100 * 15)
        .rightDown(width/100 * 10, height/100 * 35)
        .down(height/100 * 15)
        .rightDown(width/100 * 10, height/100 * 35)
        .right(width/100 * 15)
        .up(height/100 * 10)
        .right(width/100 * 65)
        .up(height/100 * 90)
        .left(width)
    
    return easierPath.path
}()
