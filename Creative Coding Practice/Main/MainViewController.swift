//
//  ViewController.swift
//  Creative Coding Practice
//
//  Created by Fomagran on 2021/12/27.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    let vcName:[String] = ["DavidLoadingViewController","DSViewController","ThreeDCardViewController","WaveViewController","SwingSquareViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        performSegue(withIdentifier: "show\(vcName[indexPath.row])", sender: nil)
    }
}
