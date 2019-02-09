//
//  CustomActionViewsExampleController.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 2.02.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class CustomActionViewsExampleController: UIViewController {
    
    let actionWidth: CGFloat = 45
    let cellReuseIdentifier = "ChatCell"
    let tableView = UITableView()
    var users = ["John Doe", "Adrian Smith", "Sam Wilson", "Mathew Davidson", "Johnathan Gray"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    func imageForItem(at index: Int) -> UIImage? {
        switch index {
        case 0:
            return UIImage(named: "delete-message")
        case 1:
            return UIImage(named: "speech-bubble")
        case 2:
            return UIImage(named: "video-message")
        default:
            return nil
        }
    }
}

extension CustomActionViewsExampleController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SwipeTableViewCell
        cell.dataSource = self
        cell.delegate = self
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
}

extension CustomActionViewsExampleController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell else {
            return
        }
        
        if cell.isSwiped {
            cell.resetSwipe(completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CustomActionViewsExampleController: SwipeTableViewCellDataSource {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int {
        if direction == .left {
            return 3
        }
        
        // TODO: When actions count is 0 we shouldn't swipe to that direction by default - could be overriden by the delegate
        return 0
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, widthForActionsForSwipeDirection direction: SwipeDirection) -> CGFloat {
        return actionWidth
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction {
        let action = SwipeAction { (action, indexPath) in
            print("tapped item at \(index)")
        }
        
        action.backgroundColor = UIColor(red: 216.0/255.0, green: 216.0/255.0, blue: 216.0/255.0, alpha: 1)
        if index == 0 {
            action.backgroundColor = .red
        }
        
        return action
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionViewForActionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeActionView? {
        guard let action = cell.visibleAction(at: index) else {
            return nil
        }
        
        let actionView = ChatActionView(action: action, width: actionWidth)
        actionView.imageView.image = imageForItem(at: index)
        actionView.backgroundColor = .clear
        return actionView
    }
}

extension CustomActionViewsExampleController: SwipeTableViewCellDelegate {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, shouldStartSwipeForDirection direction: SwipeDirection) -> Bool {
        if direction == .right {
            return false
        }
        
        return true
    }
}
