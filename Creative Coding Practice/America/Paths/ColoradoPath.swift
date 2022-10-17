//
//  Colorado.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/16.
//

import EasierPath

let coloradoPath = {
    let width:CGFloat = 150
    let height:CGFloat = 100

    let easierPath = EasierPath(0,0)
        .down(height)
        .right(width)
        .up(height)
        .left(width)
    
    return easierPath.path
}()

