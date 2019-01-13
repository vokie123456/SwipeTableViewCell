//
//  File.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 9.12.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation

@objc protocol SwipeTableViewCellDataSource {
    @objc func swipeTableViewCell(_ cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int
    @objc func swipeTableViewCell(_ cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction
    @objc func swipeTableViewCell(_ cell: SwipeTableViewCell, actionViewForActionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeActionView?
}
