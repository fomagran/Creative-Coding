//
//  Card.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/29.
//

import UIKit

class Card {
    var index:Int
    var image:UIImage
    var scale:CGFloat
    var frame:CGRect
    var point:CGPoint
    
    init(index:Int,image:UIImage,frame:CGRect,prev:Card?) {
        self.index = index
        self.image = image
        self.scale = 1
        if prev == nil{
            self.point = CGPoint(x: frame.midX - frame.width/4, y: frame.midY - frame.height/4)
            self.frame = CGRect(x:point.x, y:point.y, width:frame.width/2, height:frame.height/2)
        }else {
            self.point = CGPoint(x: prev!.point.x - prev!.frame.width/3, y: frame.midY - prev!.frame.height/3)
            self.frame = CGRect(x: point.x, y:point.y , width: prev!.frame.width/3*2, height: prev!.frame.height/3*2)
        }
    }
}
