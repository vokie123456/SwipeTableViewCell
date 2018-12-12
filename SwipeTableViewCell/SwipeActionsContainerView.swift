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
    weak var delegate: SwipeCellActionViewDelegate?
    
    private var buttons = [UIButton]()
    private var buttonWrappers = [UIView]()
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
        setup()
    }
    
    private func setup() {
        for index in 0..<actions.count {
            let action = actions[index]
            let btnWrapper = UIView()
            btnWrapper.translatesAutoresizingMaskIntoConstraints = false
            btnWrapper.backgroundColor = action.backgroundColor
            insertSubview(btnWrapper, at: 0)
            buttonWrappers.append(btnWrapper)
            
            let offset = CGFloat(index) * actionsWidth
            let btn = UIButton()
            btn.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.backgroundColor = .clear
            btn.setTitle(action.title, for: .normal)
            btnWrapper.addSubview(btn)
            buttons.append(btn)
            
            btnWrapper.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            let widthConstraint = btnWrapper.widthAnchor.constraint(greaterThanOrEqualToConstant: actionsWidth)
            widthConstraint.isActive = true
            widthConstraints.append(widthConstraint)
            var edgeConstraint: NSLayoutConstraint!
            var btnHorizontalConstraint: NSLayoutConstraint!
            if swipeDirection == .right {
                edgeConstraint = btnWrapper.leftAnchor.constraint(equalTo: leftAnchor, constant: offset)
                btnHorizontalConstraint = btn.rightAnchor.constraint(equalTo: btnWrapper.rightAnchor)
            } else {
                edgeConstraint = btnWrapper.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset)
                btnHorizontalConstraint = btn.leftAnchor.constraint(equalTo: btnWrapper.leftAnchor)
            }
            
            edgeConstraint.isActive = true
            animatableConstraints.append(edgeConstraint)
            btnHorizontalConstraint.isActive = true
            btn.widthAnchor.constraint(greaterThanOrEqualToConstant: actionsWidth).isActive = true
            btn.heightAnchor.constraint(equalTo: btnWrapper.heightAnchor).isActive = true
        }
    }
    
    @objc private func buttonTapped(button: UIButton) {
        // TODO: Implement
    }
    
    func updateButtonsConstraints(with offset: CGFloat) {
        let visibleWidth = abs(offset)
        for i in 0..<buttons.count {
            var visibleBtnWidth = visibleWidth / CGFloat(buttons.count)
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
    
    func triggerAction(at index: Int) {
        
    }
}
