//
//  UserProfileViewController.swift
//  hackathon2018
//
//  Created by max on 2018-09-04.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit

import ACPCore

class ConfigViewController: ViewController {
    @IBOutlet weak var launchCfg: UITextField!
    @IBAction func saveCfg(_ sender: Any) {
        self.saveLaunchConfiguration()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("ConfigView", data: ["category": "config"])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self.restorationIdentifier ?? "View Restoration Identifier")
    }
    /**
     * @brief Persist the new Launch config to the local app storage.
     Restarting the app will pickup this instead of the default config.
     */
    private func saveLaunchConfiguration() -> Void {
        let cfg = launchCfg.text ?? ""
        let defaults = UserDefaults.standard
        defaults.set(cfg, forKey: "launchConfig")
        print("Config saved \(cfg)")
        launchCfg.text = ""
    }
    
}
