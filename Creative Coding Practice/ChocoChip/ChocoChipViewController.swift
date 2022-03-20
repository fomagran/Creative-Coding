//
//  ChocoChipViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/03/13.
//

import UIKit

class ChocoChipViewController: UIViewController {
    
    private lazy var label:UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: .zero, size: CGSize(width: view.frame.width, height: 200))
        label.center = CGPoint(x:view.center.x, y: view.frame.height-200)
        label.textAlignment = .center
        label.text = "Fomagran"
        label.font = UIFont(name: "nutella-Bold", size: 60)
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Fomagran")
        attributedString.setColor(color: .systemRed, forText: "omagran")
        label.attributedText = attributedString
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var chocoView:UIView = {
        let v:UIView = UIView(frame:CGRect(x:0, y: view.frame.height-400, width: view.frame.width, height: 400))
        v.backgroundColor = UIColor(red: 81/255.0, green: 45/255.0, blue: 27/255.0, alpha: 1.0)
        return v
    }()

    override func loadView() {
        super.loadView()
        let cookie = CookieView(frame: CGRect(x: view.center.x-50, y: view.center.y-50, width: 100, height: 100))
        cookie.layer.cornerRadius = cookie.frame.height/2
        cookie.layer.borderColor = UIColor.black.cgColor
        cookie.layer.borderWidth = 1
        view.addSubview(cookie)
        view.addSubview(chocoView)
        view.addSubview(label)
        setNutellaEdge()
        
        let w = view.frame.width-40
        let v = UIView(frame: CGRect(x:view.center.x-w/2, y:view.frame.height-500, width:w, height: 200))
        v.backgroundColor = .white
        view.addSubview(v)
        
        let nutella = NutellaView(frame:v.frame)
        nutella.center = v.center
        nutella.layer.masksToBounds = true
        view.addSubview(nutella)
    }
    
    func setNutellaEdge() {
        let leftBottomShape:CAShapeLayer = CAShapeLayer()
        let leftBottomPath = UIBezierPath()
        leftBottomPath.move(to: CGPoint(x: 0, y: view.frame.height-100))
        leftBottomPath.addCurve(to: CGPoint(x: 50, y: view.frame.height), controlPoint1: CGPoint(x:5, y: view.frame.height-50), controlPoint2: CGPoint(x:60, y: view.frame.height))
        leftBottomPath.addLine(to: CGPoint(x:0, y: view.frame.height+25))
        leftBottomShape.strokeColor = UIColor.clear.cgColor
        leftBottomShape.fillColor = UIColor.white.cgColor
        leftBottomPath.close()
        leftBottomShape.path = leftBottomPath.cgPath
        view.layer.addSublayer(leftBottomShape)
        
        let rightBottomShape:CAShapeLayer = CAShapeLayer()
        let rightBottomPath = UIBezierPath()
        rightBottomPath.move(to: CGPoint(x:view.frame.width, y: view.frame.height-100))
        rightBottomPath.addCurve(to: CGPoint(x: view.frame.width-50, y: view.frame.height), controlPoint1: CGPoint(x:view.frame.width-5, y: view.frame.height-50), controlPoint2: CGPoint(x:view.frame.width-50, y: view.frame.height))
        rightBottomPath.addLine(to: CGPoint(x:view.frame.width, y: view.frame.height+25))
        rightBottomShape.strokeColor = UIColor.clear.cgColor
        rightBottomShape.fillColor = UIColor.white.cgColor
        rightBottomPath.close()
        rightBottomShape.path = rightBottomPath.cgPath
        view.layer.addSublayer(rightBottomShape)
        
        let leftTopShape:CAShapeLayer = CAShapeLayer()
        let leftTopPath = UIBezierPath()
        leftTopPath.move(to: CGPoint(x: 0, y: view.frame.height-300))
        leftTopPath.addCurve(to: CGPoint(x: 50, y: view.frame.height-400), controlPoint1: CGPoint(x:5, y: view.frame.height-350), controlPoint2: CGPoint(x:50, y: view.frame.height-400))
        leftTopPath.addLine(to: CGPoint(x:0, y: view.frame.height-425))
        leftTopShape.strokeColor = UIColor.clear.cgColor
        leftTopShape.fillColor = UIColor.white.cgColor
        leftTopPath.close()
        leftTopShape.path = leftTopPath.cgPath
        view.layer.addSublayer(leftTopShape)
        
        let rightTopShape:CAShapeLayer = CAShapeLayer()
        let rightTopPath = UIBezierPath()
        rightTopPath.move(to: CGPoint(x:view.frame.width, y: view.frame.height-300))
        rightTopPath.addCurve(to: CGPoint(x: view.frame.width-50, y: view.frame.height-400), controlPoint1: CGPoint(x:view.frame.width-5, y: view.frame.height-350), controlPoint2: CGPoint(x:view.frame.width-50, y: view.frame.height-400))
        rightTopPath.addLine(to: CGPoint(x:view.frame.width, y: view.frame.height-425))
        rightTopShape.strokeColor = UIColor.clear.cgColor
        rightTopShape.fillColor = UIColor.white.cgColor
        rightTopPath.close()
        rightTopShape.path = rightTopPath.cgPath
        view.layer.addSublayer(rightTopShape)
    
    }
}

extension NSMutableAttributedString {
    func setColor(color: UIColor, forText stringValue: String) {
       let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
