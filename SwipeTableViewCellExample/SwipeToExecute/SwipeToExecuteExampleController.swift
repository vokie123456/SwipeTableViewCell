//
//  SwipeToExecuteExampleController.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 2.02.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class SwipeToExecuteExampleController: UIViewController {
    
    let cellIdentifier = "ToDoCell"
    let actionWidth: CGFloat = 100
    let tableView = UITableView()
    var doneItems = Set<Int>()
    var groceries = ["Skinless chicken or turkey breasts", "Brown rice", "Tomato sauce", "Mustard", "Eggs", "Milk",
                     "Extra virgin olive oil, canola oil, nonfat cooking spray", "Hot pepper sauce", "teel-cut or instant oatmeal",
                     "Whole-grain cereal bars", "Tuna or salmon packed in water", "Diced green chilies", "Frozen vegetables: broccoli, spinach, peas, and carrots (no sauce)"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping list"
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

extension SwipeToExecuteExampleController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SwipeTableViewCell
        cell.isSwipeToExecuteEnabled = true
        cell.swipeToExecuteTreshold = 30
        cell.dataSource = self
        let attrString = NSMutableAttributedString(string: groceries[indexPath.row])
        if doneItems.contains(indexPath.row) {
            attrString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attrString.length))
        }
        
        cell.textLabel?.attributedText = attrString
        return cell
    }
}

extension SwipeToExecuteExampleController: SwipeTableViewCellDataSource {
    func swipeTableViewCell(_ cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int {
        return 1
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, widthForActionsForSwipeDirection direction: SwipeDirection) -> CGFloat {
        return actionWidth
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction {
        var action: SwipeAction!
        if direction == .left {
            action = SwipeAction(handler: { (action, indexPath) in
                guard let indexPath = indexPath else {
                    return
                }
                
                if !self.doneItems.contains(indexPath.row) {
                    return;
                }
                
                if let cell = self.tableView.cellForRow(at: indexPath) {
                    if let text = cell.textLabel?.attributedText {
                        let mutableAttrString = NSMutableAttributedString(attributedString: text)
                        mutableAttrString.removeAttribute(.strikethroughStyle, range: NSRange(location: 0, length: text.length))
                        cell.textLabel?.attributedText = mutableAttrString
                        self.doneItems.remove(indexPath.row)
                    }
                }
            })
            
            action.title = "Undo"
            action.backgroundColor = .red
        } else {
            action = SwipeAction(handler: { (action, indexPath) in
                guard let indexPath = indexPath else {
                    return
                }
                
                if self.doneItems.contains(indexPath.row) {
                    return;
                }
                
                if let cell = self.tableView.cellForRow(at: indexPath) {
                    if let text = cell.textLabel?.attributedText {
                        let mutableAttrString = NSMutableAttributedString(attributedString: text)
                        mutableAttrString.addAttribute(.strikethroughStyle, value: 2, range: NSRange(location: 0, length: text.length))
                        cell.textLabel?.attributedText = mutableAttrString
                        self.doneItems.insert(indexPath.row)
                    }
                }
            })
            
            action.title = "Mark as done"
            action.backgroundColor = .orange
        }
        
        return action
    }
    
    func swipeTableViewCell(_ cell: SwipeTableViewCell, actionViewForActionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeActionView? {
        guard let action = cell.visibleAction(at: index) else {
            return nil
        }
        
        return StackSwipeActionView(action: action, width: actionWidth)
    }
}
