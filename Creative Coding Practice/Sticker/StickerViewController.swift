//
//  StickerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/08/20.
//

import UIKit
import EasierPath

class StickerViewController: UIViewController {
    
    var timer: Timer!
    var w: CGFloat = 0
    var h: CGFloat = 0
    var d: CGFloat = 0
    var add: CGFloat = 1
    var guideView = UIView()
    var guideLabel = UILabel()
    var stickerView = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setGuideView()
        
        stickerView.frame.size = CGSize(width: 200, height: 100)
        stickerView.center = view.center
        stickerView.backgroundColor = .black
        view.addSubview(stickerView)
    }
    
    func setGuideView() {
        self.timer = Timer.scheduledTimer(timeInterval:0.03, target: self, selector: #selector(test), userInfo: nil, repeats: true)
        
        guideView = makeTransparentView(parent: view)
        view.addSubview(guideView)
        
        guideLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        guideLabel.center = CGPoint(x: view.center.x + 105, y: view.center.y-80)
        guideLabel.textColor = .black
        guideLabel.font = .boldSystemFont(ofSize: 14)
        guideLabel.text = "Pull Here!"
        
        view.addSubview(guideLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGuideView))
        guideView.addGestureRecognizer(tap)
    }
    
    @objc func tapGuideView() {
        guideLabel.removeFromSuperview()
        guideView.removeFromSuperview()
        view.layer.sublayers?.removeLast()
        view.layer.sublayers?.removeLast()
        timer.invalidate()
    }
    
    @objc func test() {
        if (view.layer.sublayers?.count ?? 0) > 3 {
            view.layer.sublayers?.removeLast()
            view.layer.sublayers?.removeLast()
        }
        w += 50/100 * add
        h += 20/100 * add
        d += 30/100 * add
        
        if w > 25 {
            add = -1
        }
        
        if add == -1 && w == 0 {
            add = 1
        }
        
        let easierPath = EasierPath(view.center.x + 100 - 50 + w*2, view.center.y - 50)
            .curve(to: .rightDown(50 - w*2,20 - h*2), .quad(.rightDown(30-d*2, 30-d*2)))
        
        let redLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .red)
        
        let easierPath2 = EasierPath(view.center.x + 100 - 50 + w, view.center.y - 50 - h)
            .rightDown(50 - w, 20 - h)
            .up(20)
            .left(50)
        
        let whiteLayer = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .white)
        
        view.layer.addSublayer(redLayer)
        view.layer.addSublayer(whiteLayer)
    }
    
    func makeTransparentView(parent:UIView) -> UIView {
        let backgroundView = UIView(frame: parent.frame)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: backgroundView.frame)
        let transparentPath = EasierPath(.circle, CGRect(x:view.center.x+40,y:view.center.y-100,width:100,height:100))
        
        backgroundPath.append(transparentPath.path)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = backgroundPath.cgPath
        backgroundView.layer.mask = maskLayer
        return backgroundView
    }
}
