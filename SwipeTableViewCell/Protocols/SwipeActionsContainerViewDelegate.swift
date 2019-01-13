//
//  SwipeActionsContainerViewDelegate.swift
//  SwipeTableViewCell
//
//  Created by Adrian Gulyashki on 3.01.19.
//  Copyright © 2019 Adrian Gulyashki. All rights reserved.
//

import UIKit

protocol SwipeActionsContainerViewDelegate: class {
    func indexPathForCellWith(actionsContainerView: SwipeActionsContainerView) -> IndexPath?
}
