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
    @objc optional func shouldStartSwipeForSwipeTableViewCell(_ cell: SwipeTableViewCell) -> Bool
    @objc optional func swipeTableViewCell(_ cell: SwipeTableViewCell, widthForActionsForSwipeDirection direction: SwipeDirection) -> CGFloat
    @objc optional func swipeTableViewCell(_ cell: SwipeTableViewCell, didTapActionAtIndex index: Int, withSwipeDirection direction: SwipeDirection)
}
