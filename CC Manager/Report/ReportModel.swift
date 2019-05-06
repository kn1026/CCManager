//
//  ReportModel.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/1/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import Foundation


class ReportModel {
    
    
    
    fileprivate var _Name: String!
    fileprivate var _Title: String!
    fileprivate var _Content: String!
    fileprivate var _Email: String!
    fileprivate var _UID: String!
    fileprivate var _Timestamp: Any!
    
    
    var Name: String! {
        get {
            if _Name == nil {
                _Name = ""
            }
            return _Name
        }
        
    }
    
    var Title: String! {
        get {
            if _Title == nil {
                _Title = ""
            }
            return _Title
        }
        
    }
    
    var Content: String! {
        get {
            if _Content == nil {
                _Content = ""
            }
            return _Content
        }
        
    }
    
    var Email: String! {
        get {
            if _Email == nil {
                _Email = ""
            }
            return _Email
        }
        
    }
    
    var UID: String! {
        get {
            if _UID == nil {
                _UID = ""
            }
            return _UID
        }
        
    }
   
    
    var TimeStamp: Any! {
        get {
            if _Timestamp == nil {
                _Timestamp = 0
            }
            return _Timestamp
        }
        
    }
    
    
    
    init(postKey: String, ReportModel: Dictionary<String, Any>) {
        
        
        if let Name = ReportModel["Name"] as? String {
            self._Name = Name
            
        }
        
        if let Title = ReportModel["Title"] as? String {
            self._Title = Title
            
        }
        
        if let Content = ReportModel["Content"] as? String {
            self._Content = Content
            
        }
        
        if let Email = ReportModel["Email"] as? String {
            self._Email = Email
            
        }
        
        if let UID = ReportModel["UID"] as? String {
            self._UID = UID
            
        }
        
        if let Timestamp = ReportModel["Timestamp"] {
            self._Timestamp = Timestamp
            
        }
        
   
        
    }
    
    

}

