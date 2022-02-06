//
//  BrokenGlassViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/02/06.
//

import UIKit

class BrokenGlassViewController: UIViewController {
    
    var glass:UIView = {
        let v:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
        v.backgroundColor = .lightGray
        v.layer.cornerRadius = 10
        return v
    }()
    
    var dot:UIView = {
        let v:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        v.backgroundColor = .black
        v.layer.cornerRadius = 2.5
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(glass)
        self.view.addSubview(dot)
        glass.center  = view.center
        setTapGesture()
    }
    
    func getEdges() {
        let edges = [CGPoint(x:view.center.x - 100,y:view.center.y),
                     CGPoint(x:view.center.x - 100,y:view.center.y-20),
                     CGPoint(x:view.center.x - 100,y:view.center.y+40),
                     CGPoint(x:view.center.x + 100,y:view.center.y),
                     CGPoint(x:view.center.x + 100,y:view.center.y-30),
                     CGPoint(x:view.center.x + 100,y:view.center.y+20),
                     CGPoint(x:view.center.x,y:view.center.y - 150),
                     CGPoint(x:view.center.x-10,y:view.center.y - 150),
                     CGPoint(x:view.center.x+60,y:view.center.y - 150),
                     CGPoint(x:view.center.x,y:view.center.y + 150),
                     CGPoint(x:view.center.x-35,y:view.center.y + 150),
                     CGPoint(x:view.center.x+15,y:view.center.y + 150)]
        for edge in edges {
            let v = UIView(frame: CGRect(x: edge.x, y: edge.y, width: 2, height: 2))
            v.backgroundColor = .red
            self.view.addSubview(v)
            let line = CAShapeLayer()
            addLine(line: line, start: dot.center, end: v.center)
        }
    }
    
    func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGlass(_:)))
        glass.addGestureRecognizer(tap)
    }
        
    @objc func tapGlass(_ sender:UITapGestureRecognizer) {
        dot.center = sender.location(in: view)
        getEdges()
    }
}
