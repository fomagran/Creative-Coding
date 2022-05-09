//
//  ZipperViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/05/07.
//

import UIKit
import AVFoundation

class ZipperViewController: UIViewController {
    
    var zl:ZipperLine!
    var zipper:Zipper!
    var zipperTop:ZipperTop!
    var angle:CGFloat = 0
    var coverView:UIView!
    var shapeLayer:CAShapeLayer = CAShapeLayer()
    var label:UILabel!
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(shapeLayer)
        view.backgroundColor = UIColor(displayP3Red: 253/255, green: 211/255, blue: 29/255, alpha: 1)
        label = UILabel(frame: CGRect(x: view.center.x-75, y: view.center.y - 50, width: 150, height: 100))
        label.text = "Zipper"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(displayP3Red: 253/255, green: 211/255, blue: 29/255, alpha: 1)
        label.font = UIFont(name: "FugazOne-Regular", size: 35)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        view.addSubview(label)
        
        coverView = UIView()
        coverView.frame = view.frame
        coverView.center = view.center
        coverView.backgroundColor = UIColor(displayP3Red: 253/255, green: 211/255, blue: 29/255, alpha: 1)
        view.addSubview(coverView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(drag(_:)))
        zl = ZipperLine(frame: CGRect(x:view.center.x - view.frame.width/2, y: view.center.y - view.frame.height/2, width: view.frame.width, height: view.frame.height))
        zl.backgroundColor = .clear
        view.addSubview(zl)
        
        zipper = Zipper(frame: CGRect(x: view.center.x-50, y: 20, width: 100, height: 100))
        zipper.backgroundColor = .clear
        view.addSubview(zipper)
        
        zipperTop = ZipperTop(frame: CGRect(x: view.center.x-5, y: 0, width: 10, height: 40))
        zipperTop.backgroundColor = .clear
        view.addSubview(zipperTop)
        
        zipper.addGestureRecognizer(panGesture)
        zipper.isUserInteractionEnabled = true
    }
    
    func setMusicPlayer(name:String,ex:String) {
        let url = Bundle.main.url(forResource:name, withExtension:ex)!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    @objc func drag(_ sender:UIPanGestureRecognizer) {
        if sender.state == .began {
            setMusicPlayer(name: "zipper", ex: "mp3")
            player?.play()
        }
        let location = sender.location(in: view)
        zipperTop.center.y = location.y - 50
        zipper.center.y = location.y
        angle = view.center.x - location.x > 0 ? min(25,view.center.x - location.x) : max(-25,view.center.x - location.x)
        zipper.transform = CGAffineTransform(rotationAngle: (angle * CGFloat.pi / 180))
        zipper.center.x = view.center.x - angle/5*4
        zl.current = (zipper.center.y-50)/view.frame.height*4
        coverView.center.y = location.y + 160
        
        let bp = UIBezierPath()
        bp.move(to:CGPoint(x: zl.topLeft, y: 0))
        bp.addLine(to: CGPoint(x: zl.topRight, y: 0))
        bp.addLine(to: CGPoint(x: view.center.x, y: location.y))
        shapeLayer.path = bp.cgPath
        shapeLayer.fillColor = UIColor.black.cgColor
        
        if location.y < view.center.y {
            self.label.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        player?.play()
        
        if sender.state == .ended {
            player?.pause()
            setMusicPlayer(name: "rattle", ex: "mp3")
            player?.play()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut) {
                self.zipper.transform = CGAffineTransform(rotationAngle: (0 * CGFloat.pi / 180))
                self.zipper.center.x = self.view.center.x
                self.label.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
        }
    }
}
