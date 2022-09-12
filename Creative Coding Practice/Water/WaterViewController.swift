//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit
import CoreMotion
import EasierPath
import AVFoundation

class WaterViewController: UIViewController {
    var fillPlayer: AVAudioPlayer?
    var dripPlayer: AVAudioPlayer?
    
    var isDrip: Bool = false
    var isDripEnabled: Bool = true
    var isLeft: Bool = true
    var isFilled: Bool = false
    var isTouchBottom: Bool = false
    
    private var dripWatertimer : Timer?
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)
    
    var dripWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 7, height: 0)))
    var bottomWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 7)))
    var waterLength: Int = 0
    var transparentView:UIView!
    lazy var waterView = Water(frame: CGRect(x: view.center.x-100, y: view.center.y-100, width: 200, height: 200))
    let label = UILabel()
    var fillButton = UIButton()
    
    let motionManager = CMMotionManager()
    var gyroTimer: Timer!
    
    override func viewDidLoad() {
        let whiteView = UIView(frame: CGRect(x: view.center.x - 100, y: view.center.y - 125, width: 200, height: 250))
        whiteView.backgroundColor = .white
        
        label.frame = CGRect(x: view.center.x-50, y: view.center.y-25, width: 100, height: 80)
        label.text = "Fomagran"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FugazOne-Regular", size: 16)
        
        view.addSubview(whiteView)
        view.addSubview(waterView)
        view.addSubview(label)
    
        transparentView = makeTransparentView(parent:view)
        view.addSubview(transparentView)
        configure()
        manageMotion()
        
        fillButton.frame = CGRect(x: view.center.x - 50, y: view.center.y + 150, width: 100, height: 100)
        fillButton.layer.cornerRadius = 50
        fillButton.backgroundColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)
        fillButton.setTitleColor(.white, for: .normal)
        fillButton.setTitle("Fill", for: .normal)
        fillButton.addTarget(self, action: #selector(startFill), for: .touchUpInside)
        
        view.addSubview(fillButton)
    }
    
    @objc func startFill() {
        waterView.startFill(percent: 0.5)
        setFillPlayer(name: "fillWater", ex: "m4a")
        fillPlayer?.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.isFilled = true
            self.fillButton.isHidden = true
        }
    }
    
    func setFillPlayer(name:String,ex:String) {
        let url = Bundle.main.url(forResource:name, withExtension:ex)!
        do {
            fillPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = fillPlayer else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func setDripPlayer(name:String,ex:String) {
        let url = Bundle.main.url(forResource:name, withExtension:ex)!
        do {
            dripPlayer = try AVAudioPlayer(contentsOf: url)
            guard let player = dripPlayer else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func manageMotion() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) {
                (data, error) in
                if let data = data {
                    let rotation = atan2(data.gravity.x, data.gravity.y) - Double.pi
                    let pivot = Int(round(rotation*100)) + 312
                    
                    if pivot < 0 {
                        if pivot < -170 {
                            self.transparentView.transform = CGAffineTransform(rotationAngle: CGFloat(-rotation))
                            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(-rotation))
                            self.isDrip = false
                            self.isDripEnabled = true
                            if self.isFilled {
                                self.fillPlayer?.pause()
                            }
                        } else {
                            if self.isDripEnabled {
                                self.isLeft = true
                                self.startDripAnimation()
                                self.setFillPlayer(name: "fillWater", ex: "m4a")
                                self.fillPlayer?.play()
                            }
                        }
                    } else {
                        if pivot > 170 {
                            self.isDrip = false
                            self.isDripEnabled = true
                            self.transparentView.transform = CGAffineTransform(rotationAngle: CGFloat(-rotation))
                            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(-rotation))
                            if self.isFilled {
                                                            self.fillPlayer?.pause()
                            }
                        } else {
                            if self.isDripEnabled {
                                self.isLeft = false
                                self.startDripAnimation()
                                self.setFillPlayer(name: "fillWater", ex: "m4a")
                                self.fillPlayer?.play()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeTransparentView(parent:UIView) -> UIView {
        let backgroundView = UIView(frame: parent.frame)
        backgroundView.backgroundColor = UIColor(displayP3Red: 245/255, green: 83/255, blue: 119/255, alpha: 1)
        
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: backgroundView.frame)
        let transparentPath = BottleShape(view:backgroundView)
        
        backgroundPath.append(transparentPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = backgroundPath.cgPath
        backgroundView.layer.mask = maskLayer
        return backgroundView
    }
    
    func configure() {
        view.backgroundColor = UIColor(displayP3Red: 245/255, green: 83/255, blue: 119/255, alpha: 1)
        
        dripWater.layer.cornerRadius = 5
        bottomWater.layer.cornerRadius = 5
        
        resetWaters()
        
        dripWater.backgroundColor = waterColor
        bottomWater.backgroundColor = waterColor
        
        view.addSubview(dripWater)
        view.addSubview(bottomWater)
        
    }
    
    func startDripAnimation() {
        isDrip = true
        isDripEnabled = false
        self.dripWatertimer = Timer.scheduledTimer(timeInterval:0.004, target: self, selector: #selector(self.startDrip), userInfo: nil, repeats: true)
        print("start")
    }
    
    func stopDripAnimation() {
        isDrip = false
        isDripEnabled = true
        dripWatertimer?.invalidate()
    }
    
    func resetWaters() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.bottomWater.alpha = 0
        } completion: { _ in
            self.dripWater.center.y = self.view.center.y
            self.bottomWater.alpha = 1
            self.isDrip = false
            self.bottomWater.frame.size.width = 0
            self.bottomWater.center.y = self.view.frame.height - 30
        }
    }
    
    @objc func startDrip() {
        if isDrip {
            dripWater.frame.size.width = 7
            dripWater.center.x = isLeft ? waterView.frame.minX : waterView.frame.maxX
            bottomWater.center.x = isLeft ? waterView.frame.minX : waterView.frame.maxX
            self.waterView.shrinkWater()
            dripWater.frame.size.height += 1
        } else {
            if dripWater.frame.size.height == 0 {
                resetWaters()
                isTouchBottom = false
                dripPlayer?.pause()
                dripWater.frame.size.width = 0
                dripWatertimer?.invalidate()
            }
            
            dripWater.center.y += 1
        }
        
        if dripWater.frame.maxY > view.frame.height - 30 {
//            if !isTouchBottom {
//                //왜 두번씩 실행되는 오류 발행할까
//                isTouchBottom = true
//                setDripPlayer(name: "flowingWater", ex: "m4a")
//                dripPlayer?.play()
//            }
            dripWater.frame.size.height -= 1
            bottomWater.frame.size.width += 0.5
            bottomWater.center.x -= 0.25
        }
    }
}
