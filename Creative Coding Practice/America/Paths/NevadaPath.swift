//
//  NevadaPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import Foundation

import EasierPath

let nevadaPath = {
    let width:CGFloat = 100
    let height:CGFloat = 200

    let easierPath = EasierPath(0,0)
        .down(height/100 * 40)
        .rightDown(width/100 * 90, height/100 * 60)
        .up(height/100 * 10)
        .right(width/100 * 10)
        .up(height/100 * 90)
        .left(width)
    
    return easierPath.path
}()

