//
//  ChatActionView.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 2.02.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

class ChatActionView: SwipeActionView {
    
    let imageView = UIImageView()
    let backgroundView = UIView()
    
    override func setupSwipeActionView() {
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        backgroundView.backgroundColor = action.backgroundColor
        backgroundView.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
