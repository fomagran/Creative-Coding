//
//  UtahPath.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let utahPath = {
    let width:CGFloat = 150
    let height:CGFloat = 200

    let easierPath = EasierPath(0,0)
        .down(height)
        .right(width)
        .up(height/100 * 80)
        .left(width/100 * 40)
        .up(height/100 * 20)
        .left(width/100 * 60)
    
    return easierPath.path
}()
