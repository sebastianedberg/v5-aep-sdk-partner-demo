//
//  MainNavigationController.swift
//  v5mobile
//
//  Created by max on 2018-09-04.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit

import ACPCore_iOS

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("MainView", data: ["category": "home"])
    }
}
