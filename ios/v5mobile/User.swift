//
//  User.swift
//  v5mobile
//
//  Created by max on 2018-10-16.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import CommonCrypto

class User {

    static fileprivate let singleton = User()
    /**
     * User singleton
     */
    static func getInstance() -> User {
        return singleton
    }
    /**
     * MD5 hashed id. Usually this comes from a crm or identity management service.
     */
    var crm_id: String
    /**
     * Authentication state
     */
    var authstate: Bool
    /**
     * Id string
     */
    var username: String
    /**
     * Password string
     * @note Not used in the moment. No authentication service is implemented in this demo.
     */
    var password: String

    fileprivate init() {
        crm_id = ""
        authstate = false
        username = ""
        password = ""
    }

    func login(_ username:String,password:String) -> String {
        self.crm_id = self.generateMD5(username) ?? ""
        self.authstate = true
        self.username = "\(username)"
        self.password = "\(password)"
        return self.crm_id
    }
    
    func logout() -> Bool {
        self.crm_id = ""
        self.authstate = false
        self.username = ""
        self.password = ""
        return true
    }
    /**
     * Helper function to generate a MD5 string.
     * @return MD5 string
     */
    private func generateMD5(_ string: String) -> String? {
        
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
