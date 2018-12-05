//
//  SwipeCellActionViewDelegate.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation

@objc protocol SwipeCellActionViewDelegate {
    @objc func swipeCellActionView(actionView: SwipeCellActionView, didTap action: SwipeAction)
}
