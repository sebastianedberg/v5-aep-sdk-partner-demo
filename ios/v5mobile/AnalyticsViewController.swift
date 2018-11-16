//
//  AnalyticsViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit

import ACPCore_iOS
import ACPAnalytics_iOS

class AnalyticsViewController: ViewController {
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var actionStateSwitch: UISwitch!
    
    @IBAction func switchAction(_ sender: Any) {
        if(actionStateSwitch.isOn) {
            label.text = "Action"
        } else {
            label.text = "State"
        }
    }
    /**
     * @brief Send ACPCore.trackAction or ACPCore.trackState
     */
    @IBAction func sendAction(_ sender: Any) {
        /**
         * data context data to attach to this hit
         */
        let data = [keyTextField.text ?? "none": valueTextField.text ?? "none"]
        /**
         * name containing the name of the state or action to track
         */
        let name = nameTextField.text ?? "Analytics"
        
        if(actionStateSwitch.isOn) {
            
            ACPCore.trackAction(name, data: data)
            
        } else {
            
            ACPCore.trackState(name, data: data)
        }
        
        keyTextField.text = ""
        valueTextField.text = ""
        nameTextField.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default view state for this view
         */
        ACPCore.trackState("AnalyticsView", data: ["category": "analytics"])
        /**
         * Get tracking identifier
         */
        ACPAnalytics.getTrackingIdentifier({trackingIdentifier in
            // use returned tracking id
            print(trackingIdentifier ?? "no tracking identifier")
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
