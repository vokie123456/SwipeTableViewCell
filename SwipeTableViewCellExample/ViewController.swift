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
        cell.dataSource = self
        return cell
    }
}

extension ViewController: SwipeTableViewCellDelegate {
    
    func swipeTableViewCell(cell: SwipeTableViewCell, widthForActionsForDirection direction: SwipeDirection) -> CGFloat {
        return 80
    }
}

extension ViewController: SwipeTableViewCellDataSource {
    func swipeTableViewCell(cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int {
        if direction == .right {
            return 2
        }
        
        return 1
    }
    
    func swipeTableViewCell(cell: SwipeTableViewCell, actionAtIndex index: Int, forDirection direction: SwipeDirection) -> SwipeAction {
        if direction == .right {
            let action = SwipeAction(handler: {action, path in})
            if index == 0 {
                action.title = "Add"
                action.backgroundColor = .green
            } else {
                action.title = "Archive"
                action.backgroundColor = .orange
            }
            
            return action
        }
        
        let deleteAction = SwipeAction(handler: {action, path in })
        deleteAction.title = "Delete"
        deleteAction.backgroundColor = .red
        return deleteAction
    }
}

extension ViewController: UITableViewDelegate {
    
}
