//
//  SwipeCellActionViewDelegate.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation

protocol SwipeActionViewDelegate: class {
    func swipeActionView(actionView: SwipeActionView, didTap action: SwipeAction)
}
