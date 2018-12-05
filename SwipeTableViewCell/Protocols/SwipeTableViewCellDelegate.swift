//
//  SwipeTableViewCellDelegate.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import Foundation
import UIKit

@objc protocol SwipeTableViewCellDelegate {
    @objc func swipeTableViewCell(cell: SwipeTableViewCell, actionsForDirection direction: SwipeDirection) -> [SwipeAction]
    @objc func shouldStartSwipeForSwipeTableViewCell(cell: SwipeTableViewCell) -> Bool
    @objc func swipeTableViewCell(cell: SwipeTableViewCell, widthForActionsForDirection direction: SwipeDirection) -> CGFloat
}
