//
//  IdentifierViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit

import ACPCore
//import ACPAudience_iOS


class IdentifierViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("IdentifierView", data: ["category": "identifier"])
        /**
         * TODO: Implement below use-case.
         */
        /*
        ACPIdentity.append(to:URL(string: "www.myUrl.com"), withCallback: {(appendedURL) in
            // handle the appended url here
            ​​print(appendedURL)
        });
         */
        
        // swift
        /*
        ACPAudience.signal(withData: ["v5mobile": "yes", "key2": "value2"], callback: {(_ response: [AnyHashable: Any]?) -> Void in
            // your customized code
            print("AAM signal: \(String(describing: response))")
        })
 
        
        ACPAudience.getVisitorProfile({(_ response: [AnyHashable: Any]?) -> Void in
            // your customized code
            print("AAM getVisitorProfile: \(String(describing: response))")
        })
         */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
    }
    
}
