//
//  WaterViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/06/18.
//

import UIKit
import EasierPath

class WaterViewController: UIViewController {
    var isDrip: Bool = false
    private var dripWatertimer : Timer?
    private var rotateBottletimer : Timer?
    private var waterColor: UIColor = UIColor(displayP3Red: 224/255, green: 239/255, blue: 247/255, alpha: 1)

    var dripWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
    var bottomWater = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 10)))
    var rotateAngle: Double = 0
    var waterLength: Int = 0
    var transparentView:UIView!
    lazy var waterView = Water(frame: CGRect(x: view.center.x-100, y: view.center.y-100, width: 200, height: 200))
    
    var startButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 50))
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    var stopButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 50))
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        let whiteView = UIView(frame: CGRect(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200))
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)

        view.addSubview(waterView)

        waterView.startFill(percent: 0.5)

        transparentView = makeTransparentView(parent:view)
        view.addSubview(transparentView)

        view.addSubview(startButton)
        startButton.center = CGPoint(x: view.center.x - 100, y: view.center.y + 200)
        startButton.addTarget(self, action:#selector(start), for: .touchUpInside)
        view.addSubview(stopButton)
        stopButton.center = CGPoint(x: view.center.x + 100, y: view.center.y + 200)
        stopButton.addTarget(self, action:#selector(stop), for: .touchUpInside)
        
        configure()
    }

    
    func makeTransparentView(parent:UIView) -> UIView {
        let backgroundView = UIView(frame: parent.frame)
        backgroundView.backgroundColor = .black
        
        let maskLayer = CAShapeLayer()
        let backgroundPath = UIBezierPath(rect: backgroundView.frame)
        let transparentPath = BottleShape(view:backgroundView)
        
        backgroundPath.append(transparentPath)
        maskLayer.fillRule = .evenOdd
        maskLayer.path = backgroundPath.cgPath
        backgroundView.layer.mask = maskLayer
        return backgroundView
    }
  
    @objc func start() {
        startRotateAnimation()
        
    }
    
    @objc func stop() {
        isDrip = false
        stopRotateAnimation()
    }
    
    func configure() {
        view.backgroundColor = .black
        
        dripWater.layer.cornerRadius = 5
        bottomWater.layer.cornerRadius = 5
        
        resetWaters()
        
        dripWater.backgroundColor = waterColor
        bottomWater.backgroundColor = waterColor
        
        view.addSubview(dripWater)
        view.addSubview(bottomWater)
        
    }
    
    func startRotateAnimation() {
        self.rotateBottletimer = Timer.scheduledTimer(timeInterval:0.05, target: self, selector: #selector(self.startRotate), userInfo: nil, repeats: true)
    }
    
    func startDripAnimation() {
        isDrip = true
        self.dripWatertimer = Timer.scheduledTimer(timeInterval:0.005, target: self, selector: #selector(self.startDrip), userInfo: nil, repeats: true)
    }
    
    func stopRotateAnimation() {
        rotateBottletimer?.invalidate()
    }
    
    func stopDripAnimation() {
        isDrip = false
        dripWatertimer?.invalidate()
    }
    
    func resetWaters() {
        UIView.animate(withDuration: 1, delay: 0) {
            self.bottomWater.alpha = 0
        } completion: { _ in
            self.dripWater.center = CGPoint(x: self.waterView.frame.minX , y: self.view.center.y)
            self.bottomWater.alpha = 1
            self.isDrip = false
            self.bottomWater.frame.size.width = 0
            self.bottomWater.center = CGPoint(x: self.waterView.frame.minX, y: self.view.frame.height - 30)
        }
    }
    
    @objc func startDrip() {
        if isDrip {
            dripWater.frame.size.height += 1
        } else {
            if dripWater.frame.size.height == 0 {
                self.resetWaters()
                dripWatertimer?.invalidate()
            }
            
            dripWater.center.y += 1
        }
        
        if dripWater.frame.maxY > view.frame.height - 30 {
            dripWater.frame.size.height -= 1
            bottomWater.frame.size.width += 0.5
            bottomWater.center.x -= 0.25
        }
    }
    
    @objc func startRotate() {
        rotateAngle -= 1
        if rotateAngle < -90 {
            rotateBottletimer?.invalidate()
            startDripAnimation()
        }
        self.transparentView.rotate(degrees:rotateAngle)
    }
    
}
