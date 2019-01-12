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
    var textColor = UIColor.black
    var font = UIFont.systemFont(ofSize: 14)
    var backgroundColor = UIColor.clear
    var image: UIImage?
    var imageSize: CGFloat = 24
    
    let handler:(SwipeAction, IndexPath?) -> Void
    
    init(handler: @escaping (SwipeAction, IndexPath?) -> Void) {
        self.handler = handler
    }
}
