//
//  BaseClient.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 23/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit


class BaseClient: NSObject {
    
    var urlAPI = "https://gateway.marvel.com:443/v1/public/characters?apikey=e4a22448c0b7904fca1e548d4b6aabbb"
    var apiKeyPublic = "e4a22448c0b7904fca1e548d4b6aabbb"
    var apiKeyPrivate = "b2443f7399df7aed5be4437062c2991ce8b8b81f"
    var timestamp =  NSDate().timeIntervalSinceNow
    
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    func mountBaseURL() -> String
    {
        let hashAPI = MD5(string: String(timestamp) + apiKeyPrivate + apiKeyPublic)
        let md5Hex =  hashAPI.map { String(format: "%02hhx", $0) }.joined()
        return  urlAPI + "&ts=" + String(timestamp) + "&hash=" + md5Hex
    }
}
