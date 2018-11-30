//
//  SwipeCellActionView.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

class SwipeCellActionView: UIView {
    let actions: [SwipeAction]
    let swipeDirection: SwipeDirection
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    init(actions:[SwipeAction], swipeDirection: SwipeDirection) {
        self.actions = actions
        self.swipeDirection = swipeDirection
        super.init(frame: .zero)
    }
}
