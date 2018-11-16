//
//  Logger.swift
//  v5mobile
//
//  Created by max on 2018-10-08.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation

class Logger {
    static fileprivate let singelton = Logger()
    fileprivate var logs:[String]
    
    static func getInstance() -> Logger {
        return singelton
    }
    
    fileprivate init() {
        logs = [String]()
    }
    
    func log(_ message:String) {
        print("v5mobile: \(message)")
        logs.append(message)
    }
    
    func getMessages() ->[String] {
        return logs
    }
}
