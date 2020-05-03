//
//  ViewController.swift
//  StickyTableHeader
//
//  Created by Ahmed masoud on 5/1/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerFrame = CGRect(x: 20, y: 0, width: tableView.frame.size.width, height: 100)
        let containerView = UIView(frame: containerFrame)
        containerView.backgroundColor = .yellow
        let sectionLabel = UILabel(frame: containerView.frame)
        sectionLabel.backgroundColor = .clear
        sectionLabel.text = "Sticky part"
        containerView.addSubview(sectionLabel)
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }


}

