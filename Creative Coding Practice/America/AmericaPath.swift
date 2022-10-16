//
//  AmericaShape.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/10/15.
//

import SwiftUI
import EasierPath

struct AmericaPath: SwiftUI.Shape {
    let easierPath = EasierPath(0,0)
        .right(100)
        .down(100)
        .left(100)
        .up(100)
    
    func path(in rect: CGRect) -> Path {
        let path = Path(easierPath.path.cgPath)
        return path
    }
}

