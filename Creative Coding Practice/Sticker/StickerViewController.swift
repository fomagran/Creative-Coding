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
    var add: CGFloat = 1
    var guideView = UIView()
    var guideLabel = UILabel()
    var stickerView = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = .white
        setGuideView()
        setStickerView()
    }
    
    func setStickerView() {
        stickerView.frame.size = CGSize(width: 200, height: 100)
        stickerView.center = view.center
        stickerView.backgroundColor = .black
        stickerView.text = "Fomagran"
        stickerView.textAlignment = .center
        stickerView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        stickerView.textColor = .brown
        stickerView.isUserInteractionEnabled = true
        view.addSubview(stickerView)
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(dragStickerView(_:)))
        stickerView.addGestureRecognizer(tap)
    }
    
    func setGuideView() {
        self.timer = Timer.scheduledTimer(timeInterval:0.03, target: self, selector: #selector(guideAnimation), userInfo: nil, repeats: true)
        
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
    
    func updateSticker() {
        if (view.layer.sublayers?.count ?? 0) > 3 {
            view.layer.sublayers?.removeLast()
            view.layer.sublayers?.removeLast()
        }
        
        stickerView.backgroundColor = w > 200 ? .white : .black
        stickerView.textColor = w > 200 ? .white : .brown
        
        let down = w <= 200 ? 0 : min(50,w - 200)
        
        let easierPath = EasierPath(view.center.x + 100, view.center.y - 50 + down)
            .left(min(w,250))
            .down(min(h,200))
            .right(h <= 100 ? w : min(w,100))
            .up(min(h,200))
        
        let redLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .red)
        
        let easierPath2 = EasierPath(view.center.x + 100, view.center.y - 50)
            .left(w <= 200 ? w :200 - (w - 200))
            .rightDown(w <= 200 ? w :200 - (w - 200), h)
            .up(h)
        
        let whiteLayer = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .white)
        
        view.layer.addSublayer(redLayer)
        view.layer.addSublayer(whiteLayer)
    }
    
    @objc func dragStickerView(_ sender:UIPanGestureRecognizer) {
        (w,h) = (0,0)
        
        let point = sender.location(in: stickerView)
        
        if sender.state == .changed {
            w = 200 - point.x
            h = point.y
        } else if sender.state == .ended {
            (w,h) = (0,0)
        }
        
        updateSticker()
    }
    
    @objc func tapGuideView() {
        guideLabel.removeFromSuperview()
        guideView.removeFromSuperview()
        view.layer.sublayers?.removeLast()
        view.layer.sublayers?.removeLast()
        timer.invalidate()
    }
    
    @objc func guideAnimation() {
        
        w += 50/100 * add
        h += 50/100 * add
        
        if w > 15 {
            add = -1
        }
        
        if add == -1 && w == 0 {
            add = 1
        }
        
        if (view.layer.sublayers?.count ?? 0) > 3 {
            view.layer.sublayers?.removeLast()
            view.layer.sublayers?.removeLast()
        }
        
        let easierPath = EasierPath(view.center.x + 100, view.center.y - 50)
            .left(w)
            .down(h)
            .right(w)
            .up(h)
        
        let redLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: .red)
        
        let easierPath2 = EasierPath(view.center.x + 100, view.center.y - 50)
            .left(w)
            .rightDown(w, h)
            .up(h)
        
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
