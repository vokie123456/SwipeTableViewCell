//
//  StackSwipeActionView.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 13.01.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class StackSwipeActionView: SwipeActionView {
    
    private let label = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let interitemSpacing: CGFloat = 8
    private let actionViewWidth: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    override init(action: SwipeAction, width: CGFloat) {
        actionViewWidth = width
        super.init(action: action, width: width)
    }
    
    override func setupSwipeActionView() {
        applyActionData()
        prepareLayout()
    }
    
    // MARK: Private functions
    
    private func prepareLayout() {
        addSubview(stackView)
        if imageView.image != nil {
            stackView.addArrangedSubview(imageView)
        }
        
        if !action.title.isEmpty {
            stackView.addArrangedSubview(label)
        }
        
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
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    private func applyActionData() {
        backgroundColor = action.backgroundColor
        label.text = action.title
        label.numberOfLines = 0
        label.textColor = action.textColor
        label.font = action.font
        imageView.image = action.image
    }
}
