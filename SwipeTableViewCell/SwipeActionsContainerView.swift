//
//  SwipeCellActionView.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

class SwipeActionsContainerView: UIView {
    let actions: [SwipeAction]
    let swipeDirection: SwipeDirection
    weak var delegate: SwipeActionsContainerViewDelegate?
    weak var dataSource: SwipeActionsContainerViewDataSource? {
        didSet {
            if let _ = dataSource {
                setup()
            }
        }
    }
    
    private var actionViews = [SwipeActionView]()
    private var widthConstraints = [NSLayoutConstraint]()
    private var animatableConstraints = [NSLayoutConstraint]()
    private let actionsWidth: CGFloat

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(actions:[SwipeAction], swipeDirection: SwipeDirection, actionsWidth: CGFloat) {
        self.actions = actions
        self.swipeDirection = swipeDirection
        self.actionsWidth = actionsWidth
        super.init(frame: .zero)
    }
    
    private func setup() {
        guard let ds = dataSource else {
            return
        }
        
        for index in 0..<actions.count {
            let offset = CGFloat(index) * actionsWidth
            let actionView = ds.swipeActionsContainerView(self, actionViewForActionAtIndex: index)
            if let actionView = actionView {
                actionView.delegate = self
                actionView.translatesAutoresizingMaskIntoConstraints = false
                insertSubview(actionView, at: 0)
                actionViews.append(actionView)
                
                // height
                actionView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
                
                // width
                let widthConstraint = actionView.widthAnchor.constraint(greaterThanOrEqualToConstant: actionsWidth)
                widthConstraint.isActive = true
                widthConstraints.append(widthConstraint)
                
                var edgeConstraint: NSLayoutConstraint!
                if swipeDirection == .right {
                    edgeConstraint = actionView.leftAnchor.constraint(equalTo: leftAnchor, constant: offset)
                } else {
                    edgeConstraint = actionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset)
                }
                
                edgeConstraint.isActive = true
                animatableConstraints.append(edgeConstraint)
            }
        }
    }
    
    func updateButtonsConstraints(with offset: CGFloat) {
        let visibleWidth = abs(offset)
        for i in 0..<actionViews.count {
            var visibleBtnWidth = visibleWidth / CGFloat(actionViews.count)
            var maxWidth = actionsWidth
            if visibleBtnWidth >= actionsWidth {
                visibleBtnWidth = ((visibleBtnWidth - actionsWidth) / 2) + actionsWidth
                maxWidth = visibleBtnWidth
            }
            
            let widthConstraint = widthConstraints[i]
            widthConstraint.constant = maxWidth
            
            var btnConstraintOffset = maxWidth - (CGFloat((i + 1)) * visibleBtnWidth)
            if swipeDirection == .right {
                btnConstraintOffset *= -1
            }
            
            let horizontalConstraint = animatableConstraints[i]
            horizontalConstraint.constant = btnConstraintOffset
        }
    }
    
    func updateSwipeToExecuteActionConstraints(with offset: CGFloat) {
        let horizontalConstraint = animatableConstraints[0]
        let widthConstraint = widthConstraints[0]
        horizontalConstraint.constant = 0
        widthConstraint.constant = abs(offset)
    }
}

extension SwipeActionsContainerView: SwipeActionViewDelegate {
    func swipeActionView(actionView: SwipeActionView, didTap action: SwipeAction) {
        guard let delegate = delegate else {
            return
        }
        
        action.handler(action, delegate.indexPathForCellWith(actionsContainerView: self))
    }
}
