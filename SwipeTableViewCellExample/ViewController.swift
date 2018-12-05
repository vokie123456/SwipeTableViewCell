//
//  ViewController.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 25.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SwipeTableViewCell
        cell.textLabel?.text = "tadaaa"
        cell.delegate = self
        return cell
    }
}

extension ViewController: SwipeTableViewCellDelegate {
    func swipeTableViewCell(cell: SwipeTableViewCell, actionsForDirection direction: SwipeDirection) -> [SwipeAction] {
        let a = SwipeAction(handler: {action, path in })
        a.title = "Delete"
        a.backgroundColor = .red
        return [a]
    }
    
    func swipeTableViewCell(cell: SwipeTableViewCell, widthForActionsForDirection direction: SwipeDirection) -> CGFloat {
        return 60
    }
    
    func shouldStartSwipeForSwipeTableViewCell(cell: SwipeTableViewCell) -> Bool {
        return true
    }
}

extension ViewController: UITableViewDelegate {
    
}
