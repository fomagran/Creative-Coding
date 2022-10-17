//
//  ArizonaPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let arizonaPath = {
    let width:CGFloat = 150
    let height:CGFloat = 200

    let easierPath = EasierPath(0,height/100 * 15)
        .down(height/100 * 15)
        .rightDown(width/100 * 5, height/100 * 25)
        .leftDown(width/100 * 5, height/100 * 15)
        .down(height/100 * 15)
        .right(width/100 * 20)
        .rightDown(width/100 * 30, height/100 * 15)
        .right(width/100 * 50)
        .up(height)
        .left(width/100 * 85)
        .down(height/100 * 15)
        .left(width/100 * 15)
    
    return easierPath.path
}()
