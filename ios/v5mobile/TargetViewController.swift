//
//  TargetViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit
import ACPCore
import ACPTarget
//import ACPTargetVEC

class TargetViewController: ViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func requestDMImage(_ sender: Any) {
        
        var dynamicMediaTitle = "unknown-user"
        if (User.getInstance().authstate) {
            dynamicMediaTitle = User.getInstance().username
        }
                
        let url = URL(string: "http://s7g3.scene7.com/is/image/AdobeDACHSC/offer?$layer_1_bgcolor=003399&$offertxt=\(dynamicMediaTitle)&$layer_2_textattr=32%2Csharp")
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
    @IBAction func requestAbTest(_ sender: Any) {
        
        var mboxParams = ["mobileUserType":"standard"]
        if (User.getInstance().authstate) {
            mboxParams = ["mobileUserType": "platinum"]
        }
        let profileParameters = ["keyword":"50% off"]
        let request = ACPTargetRequestObject(name: "abMobileOffer", defaultContent: "Default AB Offer Content", mboxParameters: mboxParams, callback: {(content: String?) -> Void in
            
            print("target response: \(String(describing: content))")
            
            DispatchQueue.main.async {
                self.textView.text = content
            }
        })
        let requests = [request]
        ACPTarget.loadRequests(requests, withProfileParameters: profileParameters)
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func requestAutomatedOffer(_ sender: Any) {
        
        var mboxParams = ["mobileUserType":"standard"]
        if (User.getInstance().authstate) {
            mboxParams = ["mobileUserType": "platinum"]
        }
        let request = ACPTargetRequestObject(name: "automatedMobileOffer", defaultContent: "", mboxParameters: mboxParams, callback: {(content: String?) -> Void in
            
            print("target response: \(String(describing: content))")
            
            var offerContent = String(content ?? "")
            if (offerContent.count > 0) {
                let range = offerContent.index(offerContent.endIndex, offsetBy: -3)..<offerContent.endIndex
                offerContent.removeSubrange(range)
                let startIndex = offerContent.index(offerContent.startIndex, offsetBy: 10)
                print("startIndex: \(startIndex) -- endIndex: \(range)")
                let imgHref = offerContent[startIndex...]
                print("url: \(imgHref)")
                let url = URL(string: String(imgHref))
                
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            }
        })
        
        let requests = [request]
        ACPTarget.loadRequests(requests, withProfileParameters: [:])
    }
    
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
        
        /*
        let mboxParams = ["mboxparam1":"mboxvalue1"]
        let profileParams = ["profilekey1":"profilevalue1"]
        let product : TargetProduct = TargetProduct.init(productId: "1234", categoryId: "furniture")
        let order : TargetOrder = TargetOrder.init(orderId: "12345", total: 123.45, purchasedProductIds: ["100", "200"])
        let targetParams : TargetParameters = TargetParameters.init(parameters: mboxParams, profileParameters: profileParams, product: product, order: order)
        ACPTargetVEC.setGlobalRequest(targetParams)
        */
        
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

