//
//  StickerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/08/20.
//

import UIKit
import EasierPath
import AVFAudio

class StickerViewController: UIViewController {
    
    var player: AVAudioPlayer?
    private var timer: Timer!
    private var w: CGFloat = 0
    private var h: CGFloat = 0
    private var add: CGFloat = 1
    private var guideView = UIView()
    private var guideLabel = UILabel()
    private var stickerLabel = UILabel()
    private var backgroundColor = UIColor(displayP3Red: 217/255, green: 227/255, blue: 36/255, alpha: 1)
    private var stickerColor = UIColor(displayP3Red: 46/255, green: 132/255, blue: 121/255, alpha: 1)
    private var stickerBackColor = UIColor(displayP3Red: 125/255, green: 161/255, blue: 133/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.backgroundColor = backgroundColor
        setGuideView()
        setStickerView()
    }
    
    func setStickerView() {
        stickerLabel.frame.size = CGSize(width: 200, height: 100)
        stickerLabel.center = view.center
        stickerLabel.isUserInteractionEnabled = true
        stickerLabel.backgroundColor = stickerColor
        stickerLabel.text = "Sticker"
        stickerLabel.textAlignment = .center
        stickerLabel.textColor = .white
        stickerLabel.font = UIFont(name: "FugazOne-Regular", size: 30)
        
        view.addSubview(stickerLabel)
        
        let tap = UIPanGestureRecognizer(target: self, action: #selector(dragStickerView(_:)))
        stickerLabel.addGestureRecognizer(tap)
    }
    
    func setFillPlayer(name:String,ex:String) {
        let url = Bundle.main.url(forResource:name, withExtension:ex)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
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
        if (view.layer.sublayers?.count ?? 0) > 2 {
            view.layer.sublayers?.removeLast()
            view.layer.sublayers?.removeLast()
        }
        
        stickerLabel.backgroundColor = w > 200 ? backgroundColor : stickerColor
        stickerLabel.textColor = w > 200 ? backgroundColor : .white
        
        let down = w <= 200 ? 0 : min(50,w - 200)
        
        let easierPath = EasierPath(view.center.x + 100, view.center.y - 50 + down)
            .left(min(w,250))
            .down(min(h,200))
            .right(h <= 100 ? w : min(w,100))
            .up(min(h,200))
        
        let backLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: stickerBackColor)
        
        let easierPath2 = EasierPath(view.center.x + 100, view.center.y - 50)
            .left(w <= 200 ? w :200 - (w - 200))
            .rightDown(w <= 200 ? w : 200 - (w - 200), h)
            .up(h)
        
        let backgroundLayer = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: backgroundColor)
        
        view.layer.addSublayer(backLayer)
        view.layer.addSublayer(backgroundLayer)
    }
    
    @objc func dragStickerView(_ sender:UIPanGestureRecognizer) {
        (w,h) = (0,0)
        
        let point = sender.location(in: stickerLabel)
        
        if sender.state == .began {
            setFillPlayer(name: "peelingSticker", ex: "m4a")
            player?.play()
        } else if sender.state == .changed {
            w = 200 - point.x
            h = point.y
        } else if sender.state == .ended {
            (w,h) = (0,0)
            player?.pause()
        }
        
        if point.x > stickerLabel.frame.width || point.y < 0 {
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
        
        let backLayer = easierPath.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: stickerBackColor)
        
        let easierPath2 = EasierPath(view.center.x + 100, view.center.y - 50)
            .left(w)
            .rightDown(w, h)
            .up(h)
        
        let backgroundLayer = easierPath2.makeLayer(lineWidth: 1, lineColor: .clear, fillColor: backgroundColor)
        
        view.layer.addSublayer(backLayer)
        view.layer.addSublayer(backgroundLayer)
        
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
