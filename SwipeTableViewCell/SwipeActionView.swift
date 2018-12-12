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
    
    private let label = UILabel()
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(action: SwipeAction) {
        self.action = action
        super.init(frame: .zero)
        setupLayout()
    }
    
    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        addSubview(stackView)
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
    }
    

}
