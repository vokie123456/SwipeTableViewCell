//
//  SwipeAction.swift
//  SwipeCell
//
//  Created by Adrian Gulyashki on 30.11.18.
//  Copyright © 2018 Adrian Gulyashki. All rights reserved.
//

import UIKit

open class SwipeAction: NSObject {
    var title = ""
    var backgroundColor = UIColor.clear
    var image: UIImage?
    var width: CGFloat = 60
    
    let handler:(SwipeAction, IndexPath?) -> Void
    
    init(handler: @escaping (SwipeAction, IndexPath?) -> Void) {
        self.handler = handler
    }
}
