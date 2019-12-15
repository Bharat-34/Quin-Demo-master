//
//  Networkhelper.swift
//  Quin Demo
//
//  Created by krishna on 13/12/19.
//  Copyright © 2019 david. All rights reserved.
//

import UIKit

class NetworkHelper: NSObject {
    
    func get(withurl urlobj:String, withparameters parameters:String, completionhandler completionblock:@escaping(_ response:Dictionary<String,AnyObject>,_ error:String) -> Void)
    {
        let url = URL(string: urlobj)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.httpBody = parameters.data(using: .utf8)
        
      
        }
                
        
}
