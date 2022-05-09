//
//  ViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    @IBOutlet weak var table: UITableView!
    
    let vcName:[String] = ["DavidLoading","DS","ThreeDCard","Wave","SwingSquare","LP","MacMiller","BrokenGlass","ChocoChip","Transformer","Zipper"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

    }
}

extension MainViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vcName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MainTableViewCell") as! MainTableViewCell
        cell.label.text = vcName[indexPath.row]
        return cell
    }
}

extension MainViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "show\(vcName[indexPath.row])ViewController", sender: nil)
    }
}
