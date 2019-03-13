//
//  LoginViewController.swift
//  v5mobile
//
//  Created by max on 2018-09-04.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit

import ACPCore

class LoginViewController: ViewController {
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    /**
     * Hashed id of e-mail string
     */
    var hashedId:String = ""
    /**
     * E-mail string
     */
    var emailId:String = ""
    /**
     * Experience Cloud Id
     */
    var ecid:String = ""
    /**
     * @brief Send hashed id string as identifier to Experience Cloud Id service.
     */
    @IBAction func loginTapped(_ sender: Any) {
        /**
         * MD5 hash of id.
         ™ @note Use proper hashing algorithm in case real customer data is handled
         */
        self.hashedId = User.getInstance().login(userNameTextField.text!, password: passwordTextField.text ?? "")
        print("hashed id - \(self.hashedId)")
        
        self.emailId = userNameTextField.text ?? "no@email.com"
        /**
         * Send login action.
         */
        ACPCore.trackAction("LoginAction", data: ["login": "yes"])
        /**
         * Sync the identifier for cross-device identification with the hashed id and the authenticated state to the x_device_id data source in AAM.
         */
        ACPIdentity.syncIdentifier("x_device_id", identifier: hashedId, authentication: ACPMobileVisitorAuthenticationState.authenticated)
        
        DispatchQueue.main.async {
            let text = "Hashed Id: \(self.hashedId)";
            self.outputTextView.text = text;
        }
        
        self.collectPII(hashedId: self.hashedId)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("LoginView", data: ["category": "login"])
        /**
         * Get ECID from the ID service.
         */
        ACPIdentity.getExperienceCloudId { (retrievedCloudId) in
            // handle the retrieved Id here
            print("getExperienceCloudId")
            DispatchQueue.main.async {
                let text = "Retrieved Experience Cloud Id: \(retrievedCloudId ?? "no value")";
                self.outputTextView.text = text;
                self.ecid = retrievedCloudId ?? "no ecid received";
            }
        }
        /**
         * Get identifiers from the ID service.
         */
        ACPIdentity.getIdentifiers { (retrievedVisitorIds) in
            // handle the retrieved Identifiers here
            print("getIdentifiers")
            for vId in retrievedVisitorIds ?? [] {
                print(vId)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        print(textView.text); //the textView parameter is the textView where text was changed
    }
    /**
     * @brief Send PII to Adobe Campaign Standard
     * @note Not implemented yet.
     */
    func collectPII(hashedId:String) {
        /**
         * @example Launch rule - Send PII
         {
         "pushPlatform": "{%%pushPlatform%%}",
         "marketingCloudId": "{%%mcid%%}",
         "cusExternalId": "{%%hashedId%%}"
         }
        */
        
        print("collecting PII for: \(hashedId)")
        
        let data:[String:String] = ["pushPlatform":"apns",
                                    "hashedId": hashedId]
        ACPCore.collectPii(data)
    }
    
}
