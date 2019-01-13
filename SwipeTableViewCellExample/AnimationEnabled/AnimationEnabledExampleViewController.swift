//
//  AnimationEnabledExampleViewController.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 13.01.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class AnimationEnabledExampleViewController: UIViewController {
    
    var numberOfMessages = 100
    let actionWidth: CGFloat = 70
    let cellIdentifier = "MessageCell"
    let tableView = UITableView()
    var readMessages = Set<Int>()
    var archiveMessages = Set<Int>()
    var pinnedMessages = Set<Int>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
    }
    
    func leftAction(at index: Int) -> SwipeAction {
        var action: SwipeAction!
        switch index {
        case 0:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    self.numberOfMessages -= 1
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            })
            
            action.title = "Delete"
            action.textColor = .white
            action.backgroundColor = .red
            break
        case 1:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    self.pinnedMessages.insert(indexPath.row)
                }
            })
            
            action.title = "Pin"
            action.textColor = .white
            action.backgroundColor = .orange
            break
        case 2:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    self.archiveMessages.insert(indexPath.row)
                }
            })
            
            action.title = "Archive"
            action.textColor = .white
            action.backgroundColor = .purple
            break
        default:
            break
        }
        
        return action
    }
}

extension AnimationEnabledExampleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfMessages
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? SwipeTableViewCell
        if cell == nil {
            cell = SwipeTableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
            cell?.dataSource = self
            cell?.delegate = self
        }
        
        cell!.accessoryType = .disclosureIndicator
        cell!.textLabel?.text = "Lorem Ipsum"
        cell!.detailTextLabel?.text = LoremIpsum.randomTextWithLength(Int(arc4random_uniform(145) + 20))
        
        return cell!
    }
}

extension AnimationEnabledExampleViewController: SwipeTableViewCellDataSource {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int {
        switch direction {
        case .left:
            return 3
        case .right:
            return 0
        default:
            return 0
        }
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, widthForActionsForSwipeDirection direction: SwipeDirection) -> CGFloat {
        return actionWidth
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction {
//        if direction == .left {
            return leftAction(at: index)
//        } else {
//
//        }
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionViewForActionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeActionView? {
        guard let action = cell.visibleAction(at: index) else {
            return nil
        }
        
        return StackSwipeActionView(action: action, width: actionWidth)
    }
}

extension AnimationEnabledExampleViewController: SwipeTableViewCellDelegate {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, didTapActionAtIndex index: Int, withSwipeDirection direction: SwipeDirection) {
        
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, shouldStartSwipeForDirection direction: SwipeDirection) -> Bool {
        if direction == .right {
            return false
        }
        
        return true
    }
}

