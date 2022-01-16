//
//  LPViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2022/01/08.
//

import UIKit
import AVFoundation

class LPViewController: UIViewController {
    
    //MARK:- UI
    
    @IBOutlet weak var scrollView: UIScrollView!

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
    
    var aperture:UIView = {
        let v = UIView()
        v.backgroundColor = .systemMint
        return v
    }()
    
    //MARK:- Properties
    
    var player: AVAudioPlayer?
    var bezier: QuadBezier!
    var line = CAShapeLayer()
    let cons = LPConstants()
    var bigLPView:LPView!
    var currentLP:LP!
    var lpViews = [LPView]()
    var niddleLineEnd = CGPoint()
    var radius:CGFloat = 0
    var smallLps:[LPView] = []
    var scrollViewTop:CGFloat = 0
    var scrollViewBottom:CGFloat = 0
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK:- Help Functions
    
    
    func configure() {
        radius = self.view.frame.width/3
        let lp = LP(title:cons.musics[0], color: .red, musicName:cons.musics[0],similarColor:cons.similarColors[0])
        bigLPView = LPView(frame: CGRect(x: view.bounds.midX-radius, y: view.bounds.midY-radius, width: radius*2, height: radius*2),lp:lp)
        currentLP = bigLPView.LP
        bigLPView.parent = self
        view.addSubview(bigLPView)
        view.layer.addSublayer(pathLayer)
        view.addSubview(needle)
        updateBigLPView(lp: currentLP)
        setPanGesture()
        niddleLineEnd = CGPoint(x: view.bounds.maxX, y: view.bounds.midY)
        bezier = setCurvedPath()
        pathLayer.path = bezier.path.cgPath
        needle.center = bezier.point(at: 0.7)
        addLine(start:CGPoint(x: needle.center.x + 20, y: needle.center.y), end:niddleLineEnd)
        setSmallLPViews()
        setScrollView()
        setAperture()
        setBigLPPanGesture()
    }
    
    func findClosestLP() -> (LPView,Int) {
        var minDistance = Int.max
        var minLP = (bigLPView!,0)
        for (i,lp) in smallLps.enumerated() {
            if lp.center.x - scrollView.contentOffset.x < 0 {
                continue
            }
            let distance = abs(lp.center.x - scrollView.contentOffset.x - bigLPView.center.x)
            if minDistance > Int(distance) {
                minDistance = Int(distance)
                minLP = (lp,i)
            }
        }
        return minLP
    }
    
    private func setBigLPPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.dragLP(_:)))
        bigLPView.addGestureRecognizer(panGesture)
    }
    
    @objc func dragLP(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        if sender.state == .began {
            UIView.animate(withDuration: 0.1) {
                let scale = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.bigLPView.transform = scale
            }
        }else if sender.state == .changed {
            bigLPView.center = location
            if scrollViewTop...scrollViewBottom ~= location.y {
                aperture.isHidden = false
            }else {
                aperture.isHidden = true
            }
            let minLP = findClosestLP()
            aperture.center.x =  minLP.0.center.x - scrollView.contentOffset.x + smallLps[0].frame.width/2
        }else {
            if  aperture.isHidden {
                UIView.animate(withDuration: 0.1) {
                    let scale = CGAffineTransform(scaleX: 1, y: 1)
                    self.bigLPView.transform = scale
                    self.bigLPView.center = self.view.center
                }
            }else {
                bigLPView.isHidden = true
                let minLP = findClosestLP()
                print(minLP.0.LP.title,minLP.0.center.x)
                let x = minLP.0.center.x  + smallLps[0].frame.width/2
                let lpView = LPView(frame: CGRect(x:x, y:0, width: radius/3*2, height: radius/3*2), lp: bigLPView.LP)
                smallLps.insert(lpView, at: minLP.1)
                let index = findClosestLP().1
                for i in index+1..<smallLps.count  {
                    smallLps[i].center.x += smallLps[0].frame.width
                }
                scrollView.contentSize.width += smallLps[0].frame.width
                scrollView.addSubview(lpView)
                lpView.parent = self
                aperture.isHidden = true
            }
        }
    }
    
    func setAperture() {
        aperture.frame = CGRect(origin:.zero, size:CGSize(width: 5, height:smallLps[0].frame.height))
        scrollViewTop = scrollView.frame.minY - aperture.frame.height/2
        scrollViewBottom = scrollView.frame.maxY - aperture.frame.height/2
        aperture.center = CGPoint(x:view.center.x - 2.5,y:scrollViewTop + aperture.frame.height/2)
        self.view.addSubview(aperture)
        aperture.isHidden = true
    }
    
    func setScrollView() {
        self.scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x:radius/3,y:0)
    }
    
    func updateBigLPView(lp:LP) {
        setMusicPlayer(lp: lp)
        self.currentLP = lp
        self.bigLPView.update(lp:currentLP)
        self.view.backgroundColor = lp.similarColor
    }
    
    func setSmallLPViews() {
        var x:CGFloat = 0
        for i in 0..<cons.colors.count {
            let lp = LP(title:cons.musics[i], color:cons.colors[i], musicName: cons.musics[i],similarColor:cons.similarColors[i])
            let lpView = LPView(frame: CGRect(x:x, y: 0, width:radius/3*2, height: radius/3*2),lp:lp)
            smallLps.append(lpView)
            scrollView.addSubview(lpView)
            scrollView.contentSize.width = lpView.frame.width * CGFloat(i + 1)
            lpViews.append(lpView)
            lpView.parent = self
            x += radius/3*2
        }
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
    
    func setCurvedPath() -> QuadBezier {
        let bounds = view.bounds
        let point1 = CGPoint(x: bounds.maxX, y: bounds.minY + 100)
        let point2 = CGPoint(x: bounds.maxX, y: bounds.maxY - 100)
        let controlPoint = CGPoint(x: bounds.maxX - CGFloat(radius), y: bounds.midY)
        let path = QuadBezier(point1: point1, point2: point2, controlPoint: controlPoint)
        return path
    }
    
    func updateNeedlePosition(_ position:CGPoint) {
        let location = position
        let t = (location.y - view.bounds.minY) / view.bounds.height
        needle.center.y = bezier.point(at: t).y
        needle.center.x = bezier.point(at: t).x - 20
        addLine(start:bezier.point(at: t), end:niddleLineEnd)
        touchLP(needle.center)
    }
    
    func touchLP(_ needle:CGPoint) {
        let distance = getTwoPointDistance(needle, bigLPView.center)
        if distance <= radius {
            if bigLPView.layer.animation(forKey: "rotation") == nil {
                bigLPView.rotate()
                player?.play()
            }
        }else {
            bigLPView.layer.removeAllAnimations()
            player?.stop()
        }
    }
    
    private func getTwoPointDistance(_ point1:CGPoint,_ point2:CGPoint) -> CGFloat {
        let xDist:CGFloat = point2.x - point1.x
        let yDist:CGFloat = point2.y - point1.y
        return sqrt((xDist * xDist) + (yDist * yDist))
    }
    
    //MARK:- @objc
    
    @objc func drag(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self.view)
        updateNeedlePosition(location)
    }
}

//MARK:- LPViewDelegate

extension LPViewController:LPViewDelegate {
    func viewTapped(view: LPView) {
        updateBigLPView(lp: view.LP)
    }
}
