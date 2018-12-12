//
//  File.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 9.12.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation

@objc protocol SwipeTableViewCellDataSource {
    @objc func swipeTableViewCell(cell: SwipeTableViewCell, numberOfActionsForSwipeDirection direction: SwipeDirection) -> Int
    @objc func swipeTableViewCell(cell: SwipeTableViewCell, actionAtIndex index: Int, forSwipeDirection direction: SwipeDirection) -> SwipeAction
}
