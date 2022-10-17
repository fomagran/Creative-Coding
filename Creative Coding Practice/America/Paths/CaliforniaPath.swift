//
//  CaliforniaPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let californiaPath = {
    let width:CGFloat = 250
    let height:CGFloat = 400

    let easierPath = EasierPath(0,0)
        .right(width/100 * 40)
        .down(height/100 * 25)
        .rightDown(width/100 * 60 , height/100 * 50)
        .rightDown(width/100 * 5, height/100 * 5)
        .leftDown(width/100 * 5, height/100 * 5)
        .down(height/100 * 10)
        .left(width/100 * 20)
        .leftUp(width/100 * 80, height/100 * 75)
        .up(height/100 * 25)
    
    return easierPath.path
}()
