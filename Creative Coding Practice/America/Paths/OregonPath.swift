//
//  OregonPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let oregonPath = {
    let width:CGFloat = 100
    let height:CGFloat = 100
    
    let easierPath = EasierPath(0,0)
        .right(width/100 * 20)
        .rightDown(width/100 * 10, height/100 * 20)
        .rightUp(width/100 * 30 , height/100 * 20)
        .right(width/100 * 40)
        .rightDown(width/100 * 10, height/100 * 10)
        .leftDown(width/100 * 10, height/100 * 30)
        .rightDown(width/100 * 5, height/100 * 10)
        .down(height/100 * 50)
        .left(width/100 * 100 + width/100 * 5)
        .up(height/100 * 100)
    
    return easierPath.path
}()
