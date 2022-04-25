//
//  TransformerViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/04/16.
//

import UIKit

class TransformerViewController: UIViewController {
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    let radius:CGFloat = .pi/2
    var buttonFrame:CGRect = .zero
    lazy var powerButton = PowerButton(frame: CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100))
    lazy var shadow = UIView(frame: CGRect(x: view.center.x - 50, y: view.center.y - 35, width: 100, height: 100))
    lazy var placeHolder:UILabel = {
       let label = UILabel()
        label.frame = CGRect(x: view.center.x - 130, y: view.center.y - 25, width: 150, height: 50)
        label.textColor = .clear
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "Enter your name"
        return label
    }()
    var alpahbet:[String] = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X","C","V","B","N","M"]
    var keyboardButons:[UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboard()
        setTapGesture()
    }
    
    private func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapInput))
        shadow.addGestureRecognizer(tap)
    }
    
    @objc func tapInput() {
        animateKeyboard(i: 0)
        self.placeHolder.text = ""
        self.placeHolder.textColor = UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 1)
    }
    
    
    private func animateKeyboard(i:Int) {
        if i == keyboardButons.count {
            return
        }
        UIView.transition(with: self.keyboardButons[i], duration:0.3, options: .transitionCrossDissolve) {
            self.keyboardButons[i].backgroundColor = UIColor(displayP3Red: 55/255, green: 55/255, blue: 55/255, alpha: 255/255)
            self.keyboardButons[i].setTitleColor(UIColor(displayP3Red: 245/255, green: 241/255, blue: 80/255, alpha: 255/255), for: .normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animateKeyboard(i: i+1)
        }
    }
    
    private func setupKeyboard() {
        var x = 0
        var y = Int(view.frame.height)-200
        for i in 0..<alpahbet.count {
            if i == 10 {
                y += 50
                x = 20
            }
            if i == 19 {
                y += 50
                x = 60
            }
            let button = KeyboardCharacter(frame: CGRect(x:x, y:y, width:Int(view.frame.width)/10-5, height: 30),character:alpahbet[i])
            button.layer.cornerRadius = 10
            view.addSubview(button)
            button.addTarget(self, action: #selector(tapKeyboardButton(_:)), for: .touchUpInside)
            keyboardButons.append(button)
            x += Int(view.frame.width)/10
        }
    }
    
    @objc func tapKeyboardButton(_ sender:UIButton) {
        placeHolder.text! += sender.titleLabel?.text ?? ""
    }
    
    private func setupUI() {
        setBackground()
        setButton()
        setupLable()
    }
    
    func setupLable() {
        view.addSubview(placeHolder)
    }
    
    func inputAnimation() {
        UIView.animate(withDuration: 2, delay: 1, options:.curveEaseInOut) {
            self.shadow.frame = CGRect(x:self.view.center.x-150, y: self.view.center.y-25, width: 300, height: 50)
            self.shadow.backgroundColor = .white
            self.shadow.layer.borderColor = UIColor.lightGray.cgColor
            self.shadow.layer.borderWidth = 2
            self.shadow.layer.shadowColor = UIColor.cyan.cgColor
            self.shadow.layer.shadowOpacity = 1
            self.shadow.layer.shadowOffset = .zero
            self.shadow.layer.shadowRadius = 10
            self.shadow.layer.masksToBounds = false
        } completion: { _ in
            UIView.transition(with: self.placeHolder, duration: 1, options: .transitionCrossDissolve) {
                self.placeHolder.textColor = .lightGray
            }
        }
    }
    
    func buttonDrawAnimation(i:Int) {
        if i == 101 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.powerButton.isReverse = true
                self.buttonReverseDrawAnimation(i: 100)
            }
            return
        }
        self.powerButton.backgroundPercent = Double(i)/100
        self.powerButton.bezierPercent = Double(i)/100
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.buttonDrawAnimation(i: i+1)
        }
    }
    
    func buttonReverseDrawAnimation(i:Int) {
        if i == -1 {
            powerButton.removeFromSuperview()
            inputAnimation()
            return
        }
        self.powerButton.bezierPercent = Double(i)/100
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            self.buttonReverseDrawAnimation(i: i-1)
        }
    }
    
    private func setButton() {
        buttonFrame = powerButton.frame
        powerButton.addTarget(self, action: #selector(tapPowerButton), for: .touchUpInside)
        powerButton.layer.cornerRadius = 20
        powerButton.layer.masksToBounds = true
        powerButton.backgroundPercent = 0
        powerButton.bezierPercent = 0
        
        shadow.backgroundColor = .black
        shadow.layer.cornerRadius = 20
        shadow.layer.masksToBounds = true
        
        view.addSubview(shadow)
        view.addSubview(powerButton)
    }
    
    @objc func tapPowerButton() {
        powerButton.center = CGPoint(x: buttonFrame.midX, y: buttonFrame.midY + 15)
        powerButton.backgroundPercent = 0
        powerButton.bezierPercent = 0
        buttonDrawAnimation(i: 0)
    }
    
    private func setBackground() {
        
        let gradientOne = UIColor(red: 50/255, green: 36/255, blue: 255/255, alpha: 1).cgColor
        let gradientTwo = UIColor(red: 34/255, green: 34/255, blue: 211/255, alpha: 1).cgColor
        let gradientThree = UIColor(red: 9/255, green: 31/255, blue: 146/255, alpha: 1).cgColor
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        
        gradient.frame = self.view.bounds
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x:0, y:0)
        gradient.endPoint = CGPoint(x:1, y:1)
        gradient.drawsAsynchronously = true
        self.view.layer.addSublayer(gradient)
        
        animateGradient()
        
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 5.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.autoreverses = true
        gradientChangeAnimation.repeatCount = Float.infinity
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
}
