//
//  SwipeActionView.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 9.12.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

class SwipeActionView: UIView {
    let action: SwipeAction
    weak var delegate: SwipeActionViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(action: SwipeAction, width: CGFloat) {
        self.action = action
        super.init(frame: .zero)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerAction))
        addGestureRecognizer(tapRecognizer)
        
        setupSwipeActionView()
    }
    
    func setupSwipeActionView() {
        fatalError("Should be overriden in subclasses")
    }
    
    @objc private func triggerAction() {
        guard let delegate = delegate else {
            return
        }
        
        delegate.swipeActionView(actionView: self, didTap: action)
    }
}
