//
//  ViewController.swift
//  v5mobile
//
//  Created by max on 2018-09-03.
//  Copyright © 2018 max. All rights reserved.
//

import UIKit

import ACPIdentity_iOS
import ACPCore_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // if logged in, fire authstate for every view
        if (User.getInstance().authstate) {
            print("logged in, fire authstate")
            ACPIdentity.syncIdentifier("x_device_id", identifier: User.getInstance().crm_id, authentication: ACPMobileVisitorAuthenticationState.authenticated)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

