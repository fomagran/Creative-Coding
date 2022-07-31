//
//  BottleShape.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/07/30.
//

import UIKit
import EasierPath

class BottleShape:UIBezierPath {
    private let width: CGFloat = 100
    private let height: CGFloat = 200
    
    init(view:UIView) {
        super.init()
        let easierPath:EasierPath = EasierPath(view.center.x - width/2, view.center.y + height/2)
        easierPath
            .right(width)
            .up(height/5*4)
            .leftUp(width/3, height/25*4)
            .up(height/25)
            .left(width/3)
            .down(height/25)
            .leftDown(width/3, height/25*4)
            .down(height/5*4)
            .end()
        self.cgPath = easierPath.path.cgPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
