//
//  SwipeTableViewCell.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

open class SwipeTableViewCell: UITableViewCell {
    
    var isSwipeEnabled = true
    var isSwipeToExecuteEnabled = true
    var isActionsAnimationEnabled = true
    var isTapToCloseEnabled = false
    var swipeToExecuteTreshold: CGFloat = 100
    weak var delegate: SwipeTableViewCellDelegate?

    private var swipeActionsView: SwipeCellActionView?
    private let panRecognizer = UIPanGestureRecognizer()
    private let tapRecognizer = UITapGestureRecognizer()
    private var isCellSwiped = false
    private var lastPan = CGPoint.zero
    private(set) weak var tableView: UITableView!
    private var cachedSelectionStyle: UITableViewCell.SelectionStyle = .default
    private var isSwipeToExecuteTriggered = false
    private var swipeDirection: SwipeDirection?
    private var totalActionsWidth: CGFloat = 0
    private var swipeToExecuteTrigger: CGFloat = 0
    
    private var swipeActionsViewLeadingConstraint: NSLayoutConstraint?
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        contentView.backgroundColor = .white
        panRecognizer.addTarget(self, action: #selector(pan(recognizer:)))
        panRecognizer.delegate = self
        addGestureRecognizer(panRecognizer)
        
        tapRecognizer.addTarget(self, action: #selector(resetSwipe))
        tapRecognizer.delegate = self
        addGestureRecognizer(tapRecognizer)
    }
    
    // MARK: Gesture recognizers
    
    @objc private func pan(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self)
        if recognizer.state == .began && !isCellSwiped {
            if isHighlighted {
                isHighlighted = false
            }
            
            let velocity = recognizer.velocity(in: self)
            swipeDirection = .right
            if velocity.x < 0 {
                swipeDirection = .left
            }
            
            cachedSelectionStyle = selectionStyle
            selectionStyle = .none
            setupSwipeActionsView(for: swipeDirection)
        } else if recognizer.state == .changed {
            cellDidSwipe(with: translation)
        } else if recognizer.state == .ended {
            swipeDidEnd(with: recognizer.velocity(in: self))
        }
    }
    
    // MARK: Overrides
    
    open override func didMoveToSuperview() {
        var superview = self.superview
        while let s = superview {
            if s.isKind(of: UITableView.self) {
                break
            } else {
                superview = s.superview
            }
        }
        
        if let superview = superview {
            tableView = superview as? UITableView
            tableView.panGestureRecognizer.removeTarget(self, action: nil)
            tableView.panGestureRecognizer.addTarget(self, action: #selector(handleTableViewPan(recognizer:)))
        }
    }
    
    // MARK: Public methods
    
    @objc func resetSwipe() {
        if frame.origin.x == 0 {
            return
        }
        
        swipeCell(to: CGPoint(x: 0, y: frame.origin.y))
    }
    
    // MARK: Private methods
    
    private func setupSwipeActionsView(for direction: SwipeDirection?) {
        guard let direction = direction, let delegate = delegate else {
            return
        }
        
        if let _ = swipeActionsView {
            swipeActionsView?.removeFromSuperview()
            swipeActionsView = nil
        }
        
        let swipeActions = delegate.swipeTableViewCell(cell: self, actionsForDirection: direction)
        let actionWidth = delegate.swipeTableViewCell(cell: self, widthForActionsForDirection: direction)
        totalActionsWidth = CGFloat(swipeActions.count) * actionWidth
        swipeToExecuteTrigger = totalActionsWidth + swipeToExecuteTreshold
        swipeActionsView = SwipeCellActionView(actions: swipeActions, swipeDirection: direction, actionsWidth: actionWidth)
        if let swipeActionsView = swipeActionsView {
            swipeActionsView.translatesAutoresizingMaskIntoConstraints = false
            swipeActionsView.delegate = self
            insertSubview(swipeActionsView, at: 0)
            swipeActionsViewLeadingConstraint = swipeActionsView.leftAnchor.constraint(equalTo: leftAnchor)
            swipeActionsViewLeadingConstraint?.isActive = true
            swipeActionsView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            swipeActionsView.heightAnchor.constraint(equalToConstant: contentView.frame.height).isActive = true
        }
    }
    
    private func cellDidSwipe(with offset: CGPoint) {
        let delta = offset.x - lastPan.x
        if abs(delta) <= 0.5 {
            return
        }
        
        var xOrigin = delta + frame.minX
        if xOrigin > 0 && xOrigin > totalActionsWidth {
            xOrigin -= (xOrigin - totalActionsWidth) / 100
        } else if xOrigin < 0 && xOrigin < -totalActionsWidth {
            xOrigin -= (xOrigin + totalActionsWidth) / 100
        }
        
        lastPan = offset
        if (swipeDirection == .left && xOrigin > 0) || (swipeDirection == .right && xOrigin < 0) {
            xOrigin = 0
        }
        
        frame = CGRect(x: xOrigin, y: frame.minY, width: frame.width, height: frame.height)
        swipeActionsViewLeadingConstraint?.constant = -xOrigin
        swipeActionsView?.updateConstraintsIfNeeded() // is this needed?
        if isSwipeToExecuteEnabled && (abs(xOrigin) >= swipeToExecuteTrigger || isSwipeToExecuteTriggered) {
            startSwipeToExcuteAnimation(with: xOrigin)
        } else if isActionsAnimationEnabled {
            swipeActionsView?.updateButtonsConstraints(with: xOrigin)
            swipeActionsView?.layoutIfNeeded()
        }
    }
    
    private func swipeDidEnd(with velocity: CGPoint) {
        if isSwipeToExecuteTriggered {
            resetSwipe()
        } else {
            var finalOrigin = CGPoint(x: 0, y: frame.minY)
            let xOrigin = frame.minX
            if xOrigin < 0 && (velocity.x < 0 || abs(xOrigin) > totalActionsWidth) {
                finalOrigin = CGPoint(x: -totalActionsWidth, y: frame.minY)
            } else if xOrigin > 0 && (velocity.x > 0 || abs(xOrigin) > totalActionsWidth) {
                finalOrigin = CGPoint(x: totalActionsWidth, y: frame.minY)
            }
            
            swipeCell(to: finalOrigin)
        }
        
        lastPan = .zero
    }
    
    private func swipeCell(to point: CGPoint) {
        swipeActionsViewLeadingConstraint?.constant = -point.x
        if isActionsAnimationEnabled {
            swipeActionsView?.updateButtonsConstraints(with: point.x)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame = CGRect(x: point.x, y: point.y, width: self.frame.width, height: self.frame.height)
            self.layoutIfNeeded()
            if self.isActionsAnimationEnabled {
                self.swipeActionsView?.layoutIfNeeded()
            }
        }, completion: { _ in
            self.isCellSwiped = self.frame.minX != 0
            if self.isSwipeToExecuteTriggered {
                self.swipeActionsView?.triggerAction(at: 0)
                self.isSwipeToExecuteTriggered = false
            }
            
            if !self.isCellSwiped {
                self.selectionStyle = self.cachedSelectionStyle
                self.swipeActionsView?.removeFromSuperview()
                self.swipeActionsView = nil
            }
        })
    }
    
    private func startSwipeToExcuteAnimation(with offset: CGFloat) {
        if abs(offset) >= swipeToExecuteTrigger {
            swipeActionsView?.updateSwipeToExecuteActionConstraints(with: offset)
            isSwipeToExecuteTriggered = true
        } else {
            swipeActionsView?.updateButtonsConstraints(with: offset)
            isSwipeToExecuteTriggered = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.swipeActionsView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func handleTableViewPan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            resetSwipe()
        }
    }
    
    // MARK: UIGestureRecognizerDelegate
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if !isSwipeEnabled || (gestureRecognizer.isEqual(tapRecognizer) && (!isCellSwiped || !isTapToCloseEnabled)) {
            return false
        }
        
        if gestureRecognizer.isEqual(panRecognizer) {
            let velocity = panRecognizer.velocity(in: self)
            var shouldStartSwipe = true
            if let delegate = delegate {
                shouldStartSwipe = delegate.shouldStartSwipeForSwipeTableViewCell(cell: self)
            }
            
            if abs(velocity.y) > abs(velocity.x) || !shouldStartSwipe {
                return false
            }
        }
        
        return true
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if superview == nil {
            return false
        }
        
        if !isCellSwiped {
            return super.point(inside: point, with: event)
        }
        
        let p = convert(point, to: superview)
        if p.y >= frame.minY && p.y <= frame.maxY {
            return true
        }
        
        return false
    }
}

extension SwipeTableViewCell: SwipeCellActionViewDelegate {
    func swipeCellActionView(actionView: SwipeCellActionView, didTap action: SwipeAction) {
        //TODO: Use delegate instead of this. This will cause retain cycle.
        action.handler(action, tableView.indexPath(for: self))

    }
}
