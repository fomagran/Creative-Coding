//
//  IdohaPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import Foundation

import EasierPath

let idahoPath = {
    let width:CGFloat = 150
    let height:CGFloat = 200

    let easierPath = EasierPath(0,0)
        .down(height/100 * 45)
        .rightDown(width/100 * 10, height/100 * 10)
        .leftDown(width/100 * 10, height/100 * 15)
        .rightDown(width/100 * 5, height/100 * 5)
        .down(height/100 * 25)
        .right(width)
        .up(height/100 * 30)
        .left(width/100 * 25)
        .leftUp(width/100 * 30, height/100 * 20)
        .up(height/100 * 10)
        .leftUp(width/100 * 35, height/100 * 30)
        .up(height/100 * 20)
        .left(width/100 * 15)
        .down(height/100 * 10)
    
    return easierPath.path
}()



