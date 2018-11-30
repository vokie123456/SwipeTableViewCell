//
//  SwipeAction.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

open class SwipeAction {
    var title = ""
    var backgroundColor = UIColor.clear
    var image: UIImage?
    
    let handler:(SwipeAction, IndexPath) -> Void
    
    init(handler: @escaping (SwipeAction, IndexPath) -> Void) {
        self.handler = handler
    }
}
