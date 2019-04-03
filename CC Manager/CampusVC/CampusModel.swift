//
//  CampusModel.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 3/31/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import Foundation


class CampusModel {
    
    
    
    fileprivate var _Name: String!
    fileprivate var _Url: String!
    
    
    var Name: String! {
        get {
            if _Name == nil {
                _Name = ""
            }
            return _Name
        }
        
    }
    
    var Url: String! {
        get {
            if _Url == nil {
                _Url = ""
            }
            return _Url
        }
        
    }
    

    
    init(postKey: String, schoolModel: Dictionary<String, Any>) {
        
        
        if let Name = schoolModel["Name"] as? String {
            self._Name = Name
            
        }
        
        if let Url = schoolModel["Url"] as? String {
            self._Url = Url
            
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
