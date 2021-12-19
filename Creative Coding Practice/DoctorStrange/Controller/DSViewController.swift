//
//  DSViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/18.
//

import UIKit
import SceneKit
import SpriteKit
import Speech

class DSViewController: UIViewController {
    
    @IBOutlet weak var speechButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let audioEngine = AVAudioEngine()
    private var recognitionTask: SFSpeechRecognitionTask?
    
    let spark = SKView(withEmitter: "Spark")
    let square = SKView(withEmitter: "SquareSpark")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.addSubview(spark)
        spark.isHidden = true
        speechRecognizer?.delegate = self
    }
    
    func setDSDoor() {
        square.frame = CGRect(x: view.bounds.midX-800, y: view.bounds.midY-800, width: 1600, height: 1600)
        square.contentMode = .scaleAspectFit
        let whiteView = setCenterCircle(view:square)
        square.addSubview(whiteView)
        view.addSubview(square)
        let imageView = UIImageView(image: UIImage(named: "폴고갱.jpeg"))
        imageView.frame = CGRect(x: view.bounds.midX-300, y: view.bounds.midY-300, width: 600, height: 600)
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = true
        view.addSubview(imageView)
    }
    
    func setCenterCircle(view:UIView) -> UIView {
        let whiteView = UIView(frame: view.bounds)
        let maskLayer = CAShapeLayer()
        let radius : CGFloat = view.bounds.width/5
        let path = UIBezierPath(rect: view.bounds)
        path.addArc(withCenter: whiteView.center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        maskLayer.path = path.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        whiteView.layer.mask = maskLayer
        whiteView.clipsToBounds = true
        whiteView.alpha = 1
        whiteView.backgroundColor = UIColor.black
        return whiteView
    }
    
    func circleAnimation() {
        spark.isHidden = false
        let flightAnimation = CAKeyframeAnimation(keyPath: "position")
        flightAnimation.path = UIBezierPath(ovalIn:CGRect(x: view.frame.midX-300, y: view.frame.midY-300, width: 600, height: 600)).cgPath
        flightAnimation.calculationMode = CAAnimationCalculationMode.paced
        flightAnimation.duration = 1
        flightAnimation.rotationMode = CAAnimationRotationMode.rotateAuto
        flightAnimation.repeatCount = 3
        spark.layer.add(flightAnimation, forKey: nil)
    }
    
    func startRecording() {
        if recognitionTask != nil {
                   recognitionTask?.cancel()
                   recognitionTask = nil
               }
               
               let audioSession = AVAudioSession.sharedInstance()
               do {
                   try audioSession.setCategory(AVAudioSession.Category.record)
                   try audioSession.setMode(AVAudioSession.Mode.measurement)
                   try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
               } catch {
                   print("audioSession properties weren't set because of an error.")
               }
               
               recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
               
               let inputNode = audioEngine.inputNode
               
               guard let recognitionRequest = recognitionRequest else {
                   fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
               }
               
               recognitionRequest.shouldReportPartialResults = true
               recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
                   
                   var isFinal = false
                   if result != nil {
                       self.textView.text = result?.bestTranscription.formattedString
                       isFinal = (result?.isFinal)!
                       if self.textView.text == "문 열어" {
                           self.stopRecording()
                           self.textView.text = ""
                           self.circleAnimation()
                           DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                               self.spark.isHidden = true
                               self.setDSDoor()
                           }
                           return
                       }
                   }
                   
                   if error != nil || isFinal {
                       self.audioEngine.stop()
                       inputNode.removeTap(onBus: 0)
                       
                       self.recognitionRequest = nil
                       self.recognitionTask = nil
                       self.speechButton.isEnabled = true
                   }
               })
               
               let recordingFormat = inputNode.outputFormat(forBus: 0)
               inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                   self.recognitionRequest?.append(buffer)
               }
               audioEngine.prepare()
               do {
                   try audioEngine.start()
               } catch {
                   print("audioEngine couldn't start because of an error.")
               }
               textView.text = "Say something, I'm listening!"
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
           if available {
               speechButton.isEnabled = true
           } else {
               speechButton.isEnabled = false
           }
       }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
 speechButton.isEnabled = false
        speechButton.setTitle("말하기!", for: .normal)
        textView.text = ""
    }
    
    @IBAction func tapSpeechButton(_ sender: Any) {
        if audioEngine.isRunning {
                  stopRecording()
               } else {
                   startRecording()
                   speechButton.setTitle("말하기 멈추기", for: .normal)
               }
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .ended {
            spark.isHidden = true
        } else if sender.state == .began {
            spark.isHidden = false
        }else if sender.state == .changed {
            spark.center = sender.location(in: self.view)
        }
    }
}

extension DSViewController:SFSpeechRecognizerDelegate{
    
}
