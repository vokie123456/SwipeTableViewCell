//
//  SwipeCellActionViewDelegate.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation

@objc protocol SwipeActionViewDelegate {
    @objc func swipeActionView(actionView: SwipeActionView, didTap action: SwipeAction)
}
