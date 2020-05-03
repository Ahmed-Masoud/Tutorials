//
//  ViewController.swift
//  StretchyTableHeader
//
//  Created by Ahmed masoud on 5/3/20.
//  Copyright © 2020 Ahmed Masoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    var headerView: UIView!
    let headerHeight: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerView = myTable.tableHeaderView
        myTable.tableHeaderView = nil
        myTable.addSubview(headerView)
        myTable.contentInset = UIEdgeInsets(top: headerHeight, left: 0, bottom: 0, right: 0)
        myTable.contentOffset = CGPoint(x: 0, y: -headerHeight)
        updateHeader()
    }
    
    func updateHeader() {
        print(myTable.contentOffset.y)
        if myTable.contentOffset.y < -headerHeight {
            headerView.frame.origin.y = myTable.contentOffset.y
            headerView.frame.size.height = -myTable.contentOffset.y
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = "[\(indexPath.section),\(indexPath.row)]"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeader()
    }
}

