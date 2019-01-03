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
    
    private let label = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(action: SwipeAction) {
        self.action = action
        super.init(frame: .zero)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerAction))
        addGestureRecognizer(tapRecognizer)
        setupLayout()
        applyActionData()
    }
    
    private func setupLayout() {
        label.textAlignment = .center
    
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }
    
    private func applyActionData() {
        backgroundColor = action.backgroundColor
        label.text = action.title
    }
    
    @objc private func triggerAction() {
        guard let delegate = delegate else {
            return
        }
        
        delegate.swipeActionView(actionView: self, didTap: action)
    }
}
