//
//  TargetViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit
import ACPCore_iOS
import ACPTarget_iOS
import ACPIdentity_iOS

class TargetViewController: ViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func requestTarget(_ sender: Any) {
        
        /**
         * @example Prefetch and store the result to avoid retriggering the same Target request.
         
         let profileParameters = ["age":"20-32"]
         let mboxParameters = ["userType": "platinum"]
         let prefetch = ACPTargetPrefetchObject(name: "buttonColor", mboxParameters: nil)
         ACPTarget.prefetchContent([prefetch], withProfileParameters: nil) { (success) in
         print("prefetchContent")
         print(success.description)
         }
         */
        var mboxParams = ["mobileUserType":"standard"]
        if (User.getInstance().authstate) {
            mboxParams = ["mobileUserType": "platinum"]
        }
        /**
         * Create Target request object with mbox name buttonColor. The first call will create the mbox name in Adobe Target. The response in this example is JSON. One could also use the HTML Offer within Target to either render html or as plain text.
         */
        let request = ACPTargetRequestObject(name: "buttonColor", defaultContent: "{\"color\":\"#ff0000\"}", mboxParameters: mboxParams, callback: {(content: String?) -> Void in
            
            print("target response: \(String(describing: content))")
            
            let json = JSON(parseJSON: content!)
            let color =  json["color"].string ?? "#ff0000"
            
            DispatchQueue.main.async {
                self.textView.text = content
                self.textView.backgroundColor = self.hexStringToUIColor(hex: color)
            }
        })
        
        let requests = [request]
        ACPTarget.loadRequests(requests, withProfileParameters: [:])
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("TargetView", data: ["category": "target"])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /**
     * @brief Helper function to convert hex to UIColor.
     */
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

