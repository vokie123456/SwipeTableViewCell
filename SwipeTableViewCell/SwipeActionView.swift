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
    private let interitemSpacing: CGFloat = 8
    private let actionViewWidth: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(action: SwipeAction, width: CGFloat) {
        self.action = action
        self.actionViewWidth = width
        super.init(frame: .zero)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(triggerAction))
        addGestureRecognizer(tapRecognizer)
        applyActionData()
        setupLayout()
    }
    
    private func setupLayout() {
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        var spacing = interitemSpacing
        var textWidth = actionViewWidth - action.imageSize
        if imageView.image == nil{
            spacing = 0
            textWidth = actionViewWidth
        }
        
        if action.title.isEmpty {
            spacing = 0
        }
        
        let labelSize = label.sizeThatFits(CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude))
        label.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: action.imageSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: action.imageSize).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.alignment = .center
        stackView.axis = .horizontal
        addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true

        if imageView.image != nil {
            stackView.addArrangedSubview(imageView)
        }
        
        if !action.title.isEmpty {
            stackView.addArrangedSubview(label)
        }
    }
    
    private func applyActionData() {
        backgroundColor = action.backgroundColor
        label.text = action.title
        label.numberOfLines = 0
        label.textColor = action.textColor
        label.font = action.font
        imageView.image = action.image
    }
    
    @objc private func triggerAction() {
        guard let delegate = delegate else {
            return
        }
        
        delegate.swipeActionView(actionView: self, didTap: action)
    }
}
