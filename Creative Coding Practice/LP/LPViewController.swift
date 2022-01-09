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
    
    //MARK:- Properties
    
    var player: AVAudioPlayer?
    var bezier: QuadBezier!
    var line = CAShapeLayer()
    let cons = LPConstants()
    var bigLPView:LPView!
    var currentLP:LP!
    var lpViews = [LPView]()
    var niddleLineEnd = CGPoint()
    
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK:- Help Functions
    
    
    func configure() {
        let lp = LP(title:cons.musics[0], color: .red, musicName:cons.musics[0],similarColor:cons.similarColors[0])
        bigLPView = LPView(frame: CGRect(x: view.bounds.midX-150, y: view.bounds.midY-150, width: 300, height: 300),lp:lp)
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
    }
    
    func setScrollView() {
        self.scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentOffset = CGPoint(x:50,y:0)
    }
    
    func updateBigLPView(lp:LP) {
        setMusicPlayer(lp: lp)
        self.currentLP = lp
        self.bigLPView.update(lp:currentLP)
        self.view.backgroundColor = lp.similarColor
    }
    
    func setSmallLPViews() {
        var x = 0
        for i in 0..<cons.colors.count {
            let lp = LP(title:cons.musics[i], color:cons.colors[i], musicName: cons.musics[i],similarColor:cons.similarColors[i])
            let lpView = LPView(frame: CGRect(x:x, y: 0, width:100, height: 100),lp:lp)
            scrollView.addSubview(lpView)
            scrollView.contentSize.width = lpView.frame.width * CGFloat(i + 1)
            lpViews.append(lpView)
            lpView.parent = self
            x += 100
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
        let controlPoint = CGPoint(x: bounds.maxX - 150, y: bounds.midY)
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
        if distance <= 150 {
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
