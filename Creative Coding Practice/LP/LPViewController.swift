//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit
import AVFoundation

class LPViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var player: AVAudioPlayer?
    var bezier: QuadBezier!
    private var line = CAShapeLayer()
    var lastLP:LPView!
    var similarColors:[UIColor] = [
        UIColor(displayP3Red: 91/255, green: 245/255, blue: 149/255, alpha:0.97),
        UIColor(displayP3Red: 91/255, green: 185/255, blue: 245/255, alpha:0.97),
        UIColor(displayP3Red: 91/255, green: 98/255, blue: 245/255, alpha:0.97),
        UIColor(displayP3Red: 245/255, green: 91/255, blue: 100/255, alpha:0.97),
        UIColor(displayP3Red: 245/255, green: 188/255, blue: 91/255, alpha:0.97),
        UIColor(displayP3Red: 245/255, green: 218/255, blue: 91/255, alpha:0.97),
        UIColor(displayP3Red: 210/255, green: 245/255, blue: 91/255, alpha:0.97)
    ]
    
    var musics:[String] = ["기다린만큼 더",
                           "Changes",
                           "Love Ya",
                           "못Understand",
                           "바람사람",
                           "나를 좋아하지 않는 그대에게",
                           "빨간차"]
                           
    
    let pathLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.clear.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
    }()
        
    var needle: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "needle.jpg")
        iv.frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    var lpView:LPView!
    var currentLP:LP!
    var lpViews = [LPView]()
    var niddleLineEnd = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lp = LP(title:musics[0], color: .red, musicName:musics[0],similarColor:similarColors[0])
        lpView = LPView(frame: CGRect(x: view.bounds.midX-150, y: view.bounds.midY-150, width: 300, height: 300),lp:lp)
        currentLP = lpView.LP
        view.addSubview(lpView)
        configure()
        setMusicPlayer(lp: lpView.LP)
        lpView.parent = self
        self.view.backgroundColor = lpView.LP.similarColor
        self.scrollView.showsHorizontalScrollIndicator = false
    }
    
    func configure() {
        view.layer.addSublayer(pathLayer)
        view.addSubview(needle)
        setPanGesture()
        niddleLineEnd = CGPoint(x: view.bounds.maxX, y: view.bounds.midY)
        bezier = buildCurvedPath()
        pathLayer.path = bezier.path.cgPath
        needle.center = bezier.point(at: 0.7)
        addLine(start:CGPoint(x: needle.center.x + 20, y: needle.center.y), end:niddleLineEnd)
        setLPViews(initX: 0)
    }
    
    func setLPViews(initX:Int) {
        var x = initX
        let colors:[UIColor] = [.systemRed,.systemOrange,.systemYellow,.systemGreen,.systemBlue,.systemIndigo,.systemPurple]
        for i in 0..<colors.count {
            let lp = LP(title:musics[i], color:colors[i], musicName: musics[i],similarColor:similarColors[i])
            let lpView = LPView(frame: CGRect(x:x, y: 0, width:100, height: 100),lp:lp)
            scrollView.addSubview(lpView)
            scrollView.contentSize.width = lpView.frame.width * CGFloat(i + 1)
            lpViews.append(lpView)
            lpView.parent = self
            x += 100
        }
        lastLP = lpViews.last!
    }
        
    func setMusicPlayer(lp:LP) {
        let url = Bundle.main.url(forResource:lp.musicName, withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.prepareToPlay()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    private func setPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.drag(_:)))
        needle.addGestureRecognizer(panGesture)
    }
    
    private func addLine(start: CGPoint, end:CGPoint) {
        line.removeFromSuperlayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.darkGray.cgColor
        line.lineWidth = 3
        view.layer.addSublayer(line)
    }
    
    //MARK:- Actions
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        updatePosition(location)
    }
    
    func buildCurvedPath() -> QuadBezier {
        let bounds = view.bounds
        let point1 = CGPoint(x: bounds.maxX, y: bounds.minY + 100)
        let point2 = CGPoint(x: bounds.maxX, y: bounds.maxY - 100)
        let controlPoint = CGPoint(x: bounds.maxX - 150, y: bounds.midY)
        let path = QuadBezier(point1: point1, point2: point2, controlPoint: controlPoint)
        return path
    }
    
    func updatePosition(_ position:CGPoint) {
        let location = position
        let t = (location.y - view.bounds.minY) / view.bounds.height
        needle.center.y = bezier.point(at: t).y
        needle.center.x = bezier.point(at: t).x - 20
        addLine(start:bezier.point(at: t), end:niddleLineEnd)
        touchLP(needle.center)
    }
    
    func touchLP(_ needle:CGPoint) {
        let distance = getTwoPointDistance(needle, lpView.center)
        if distance <= 150 {
            if lpView.layer.animation(forKey: "rotation") == nil {
                lpView.rotate()
                player?.play()
            }
        }else {
            lpView.layer.removeAllAnimations()
            player?.stop()
        }
    }
    
    func resumeAnimation(layer : CALayer){
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
    }
    
    func pauseLayer(layer : CALayer){
        let pausedTime : CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
    }
    
    private func getTwoPointDistance(_ point1:CGPoint,_ point2:CGPoint) -> CGFloat {
        let xDist:CGFloat = point2.x - point1.x
        let yDist:CGFloat = point2.y - point1.y
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
}

extension LPViewController:LPViewDelegate {
    func viewTapped(view: LPView) {
        setMusicPlayer(lp: view.LP)
        self.currentLP = view.LP
        self.lpView.update(lp:currentLP)
        self.view.backgroundColor = view.LP.similarColor
    }
}

extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotation")
    }
}
