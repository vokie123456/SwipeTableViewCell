//
//  SwipeActionsContainerViewDataSource.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 13.01.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import Foundation

protocol SwipeActionsContainerViewDataSource: class {
    func swipeActionsContainerView(_ swipeActionsContainerView: SwipeActionsContainerView, actionViewForActionAtIndex index: Int) -> SwipeActionView?
}
