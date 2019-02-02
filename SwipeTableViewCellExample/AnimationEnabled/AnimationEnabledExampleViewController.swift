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
    var swipedCell: SwipeTableViewCell?
    let animationsEnabled: Bool
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(animationsEnabled: Bool) {
        self.animationsEnabled = animationsEnabled
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mail list"
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func leftAction(at index: Int, for cell: SwipeTableViewCell) -> SwipeAction {
        var action: SwipeAction!
        switch index {
        case 0:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    if let cell = self.tableView.cellForRow(at: indexPath) as? SwipeTableViewCell {
                        cell.resetSwipe(completion: {
                            self.numberOfMessages -= 1
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        })
                    }
                }
            })
            
            action.title = "Delete"
            action.textColor = .white
            action.backgroundColor = .red
            break
        case 1:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    cell.resetSwipe(completion: {
                        if self.pinnedMessages.contains(indexPath.row) {
                            self.pinnedMessages.remove(indexPath.row)
                        } else {
                            self.pinnedMessages.insert(indexPath.row)
                        }
                    })
                }
            })
            
            var title = "Pin"
            if let path = tableView.indexPath(for: cell) {
                if pinnedMessages.contains(path.row) {
                    title = "Unpin"
                }
            }
            
            action.title = title
            action.textColor = .white
            action.backgroundColor = .orange
            break
        case 2:
            action = SwipeAction(handler: { action, indexPath in
                if let indexPath = indexPath {
                    cell.resetSwipe(completion: {
                        if self.archiveMessages.contains(indexPath.row) {
                            self.archiveMessages.remove(indexPath.row)
                        } else {
                            self.archiveMessages.insert(indexPath.row)
                        }
                    })
                }
            })
            
            var title = "Archive"
            if let path = tableView.indexPath(for: cell) {
                if archiveMessages.contains(path.row) {
                    title = "Restore"
                }
            }
            
            action.title = title
            action.textColor = .white
            action.backgroundColor = .purple
            break
        default:
            break
        }
        
        return action
    }
    
    func rightAction(for cell: SwipeTableViewCell) -> SwipeAction {
        let rightAction = SwipeAction { (action, indexPath) in
            if let indexPath = indexPath {
                cell.resetSwipe(completion: {
                    if self.readMessages.contains(indexPath.row) {
                        self.readMessages.remove(indexPath.row)
                    } else {
                        self.readMessages.insert(indexPath.row)
                    }
                })
            }
        }
        
        var title = "Mark as read"
        if let path = tableView.indexPath(for: cell) {
            if readMessages.contains(path.row) {
                title = "Unread"
            }
        }
        
        rightAction.title = title
        rightAction.textColor = .white
        rightAction.backgroundColor = .blue
        return rightAction
    }
}

extension AnimationEnabledExampleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell {
            if cell.isEqual(swipedCell) {
                swipedCell?.resetSwipe(completion: nil)
            }
        }
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
            cell?.isActionsAnimationEnabled = animationsEnabled
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
            return 1
        default:
            return 0
        }
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, widthForActionsForSwipeDirection direction: SwipeDirection) -> CGFloat {
        return actionWidth
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction {
        if direction == .left {
            return leftAction(at: index, for: cell)
        } else {
            return rightAction(for: cell)
        }
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionViewForActionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeActionView? {
        guard let action = cell.visibleAction(at: index) else {
            return nil
        }
        
        return StackSwipeActionView(action: action, width: actionWidth)
    }
}

extension AnimationEnabledExampleViewController: SwipeTableViewCellDelegate {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, shouldStartSwipeForDirection direction: SwipeDirection) -> Bool {
        return true
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, willStartSwipeForDirection direction: SwipeDirection) {
        if !cell.isEqual(swipedCell) {
            swipedCell?.resetSwipe(completion: nil)
        }
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, didEndSwipeForDirection direction: SwipeDirection) {
        swipedCell = cell
    }
}

