//
//  CharacterClient.swift
//  provaIlegra
//
//  Created by Marcelo Garcia on 23/01/18.
//  Copyright © 2018 Marcelo Garcia. All rights reserved.
//

import UIKit

protocol CharactersDelegate {
    func success(response: [Character])
}

class CharacterClient: BaseClient {
    
    var delegate:CharactersDelegate?
    
    func getCharacters(offset: String) {
        
        let urlToRequest  = NSURL(string:mountBaseURL() + "&offset=" + offset)
        let request = NSMutableURLRequest(url:urlToRequest as! URL)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    let collection = try Characters(map: Mapper(json: convertedJsonIntoDict))
                    self.delegate?.success(response: collection.list)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
        
        task.resume()
    }

}
