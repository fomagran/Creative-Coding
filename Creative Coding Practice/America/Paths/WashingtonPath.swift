//
//  WashingtonPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import SwiftUI
import EasierPath

let washingtonPath = {
    let width:CGFloat = 200
    let height:CGFloat  = 100
    
    let easierPath = EasierPath(0,height/10 * 3)
        .down(height/10 * 7)
        .right(width/10 * 2)
        .rightDown(width/10 * 1, height/5)
        .rightUp(width/10 * 3 , height/5)
        .right(width/10 * 4)
        .up(height/10 * 10)
        .left(width/10 * 7)
        .down(height/10 * 3)
        .leftUp(width/10 * 1, height/10 * 1)
        .left(width/10 * 2)
        .down(height/10 * 3 - height/10 * 1)
    
    return easierPath.path
}()




