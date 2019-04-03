//
//  applicationModel.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import Foundation


class applicationModel {
    
    
    
    fileprivate var _SSN: String!
    fileprivate var _Car1downloadUrl: String!
    fileprivate var _Car2downloadUrl: String!
    fileprivate var _CarRegistdownloadUrl: String!
    fileprivate var _DriverLics: String!
    fileprivate var _LicPlatedownloadUrl: String!
    fileprivate var _FaceIDdownloadUrl: String!
    fileprivate var _SelectedCityTxt: String!
    fileprivate var _SelectedStateTxt: String!
    fileprivate var _Selectedadd1Txt: String!
    fileprivate var _Selectedadd2Txt: String!
    fileprivate var _SelectedzipcodeTxt: String!
    fileprivate var _campus: String!
    fileprivate var _email: String!
    fileprivate var _phone: String!
    fileprivate var _userUID: String!
    fileprivate var _user_name: String!
    fileprivate var _Timestamp: Any!
    fileprivate var _birthday: String!
    
    
    
    var birthday: String! {
        get {
            if _birthday == nil {
                _birthday = ""
            }
            return _birthday
        }
        
    }
    
    var SSN: String! {
        get {
            if _SSN == nil {
                _SSN = ""
            }
            return _SSN
        }
        
    }
    
    var Car1downloadUrl: String! {
        get {
            if _Car1downloadUrl == nil {
                _Car1downloadUrl = ""
            }
            return _Car1downloadUrl
        }
        
    }
    
    var Car2downloadUrl: String! {
        get {
            if _Car2downloadUrl == nil {
                _Car2downloadUrl = ""
            }
            return _Car2downloadUrl
        }
        
    }
    
    var CarRegistdownloadUrl: String! {
        get {
            if _CarRegistdownloadUrl == nil {
                _CarRegistdownloadUrl = ""
            }
            return _CarRegistdownloadUrl
        }
        
    }
    
    var DriverLics: String! {
        get {
            if _DriverLics == nil {
                _DriverLics = ""
            }
            return _DriverLics
        }
        
    }
    
    var LicPlatedownloadUrl: String! {
        get {
            if _LicPlatedownloadUrl == nil {
                _LicPlatedownloadUrl = ""
            }
            return _LicPlatedownloadUrl
        }
        
    }
    
    var FaceIDdownloadUrl: String! {
        get {
            if _FaceIDdownloadUrl == nil {
                _FaceIDdownloadUrl = ""
            }
            return _FaceIDdownloadUrl
        }
        
    }
    
    var SelectedCityTxt: String! {
        get {
            if _SelectedCityTxt == nil {
                _SelectedCityTxt = ""
            }
            return _SelectedCityTxt
        }
        
    }
    
    var SelectedStateTxt: String! {
        get {
            if _SelectedStateTxt == nil {
                _SelectedStateTxt = ""
            }
            return _SelectedStateTxt
        }
        
    }
    
    var Selectedadd1Txt: String! {
        get {
            if _Selectedadd1Txt == nil {
                _Selectedadd1Txt = ""
            }
            return _Selectedadd1Txt
        }
        
    }
    
    var Selectedadd2Txt: String! {
        get {
            if _Selectedadd2Txt == nil {
                _Selectedadd2Txt = ""
            }
            return _Selectedadd2Txt
        }
        
    }
    
    var SelectedzipcodeTxt: String! {
        get {
            if _SelectedzipcodeTxt == nil {
                _SelectedzipcodeTxt = ""
            }
            return _SelectedzipcodeTxt
        }
        
    }
    
    var campus: String! {
        get {
            if _campus == nil {
                _campus = ""
            }
            return _campus
        }
        
    }
    
    var email: String! {
        get {
            if _email == nil {
                _email = ""
            }
            return _email
        }
        
    }
    
    var phone: String! {
        get {
            if _phone == nil {
                _phone = ""
            }
            return _phone
        }
        
    }
    
    var userUID: String! {
        get {
            if _userUID == nil {
                _userUID = ""
            }
            return _userUID
        }
        
    }
    
    var user_name: String! {
        get {
            if _user_name == nil {
                _user_name = ""
            }
            return _user_name
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
    
    
    
    init(postKey: String, applicationModel: Dictionary<String, Any>) {
        
   
        if let Car1downloadUrl = applicationModel["Car1downloadUrl"] as? String {
            self._Car1downloadUrl = Car1downloadUrl
            
        }
        
        if let Car2downloadUrl = applicationModel["Car2downloadUrl"] as? String {
            self._Car2downloadUrl = Car2downloadUrl
            
        }
        
        if let CarRegistdownloadUrl = applicationModel["CarRegistdownloadUrl"] as? String {
            self._CarRegistdownloadUrl = CarRegistdownloadUrl
            
        }
        
        if let DriverLics = applicationModel["DriverLics"] as? String {
            self._DriverLics = DriverLics
            
        }
        
        if let LicPlatedownloadUrl = applicationModel["LicPlatedownloadUrl"] as? String {
            self._LicPlatedownloadUrl = LicPlatedownloadUrl
            
        }
        
        if let FaceIDdownloadUrl = applicationModel["DriverFaceIDdownloadUrl"] as? String {
            self._FaceIDdownloadUrl = FaceIDdownloadUrl
            
        }
        
        
        if let SelectedCityTxt = applicationModel["SelectedCityTxt"] as? String {
            self._SelectedCityTxt = SelectedCityTxt
            
        }
        
        if let SelectedStateTxt = applicationModel["SelectedStateTxt"] as? String {
            self._SelectedStateTxt = SelectedStateTxt
            
        }
        
        if let Selectedadd1Txt = applicationModel["Selectedadd1Txt"] as? String {
            self._Selectedadd1Txt = Selectedadd1Txt
            
        }
        
        if let Selectedadd2Txt = applicationModel["Selectedadd2Txt"] as? String {
            self._Selectedadd2Txt = Selectedadd2Txt
            
        }
        
        if let SSN = applicationModel["SSNum"] as? String {
            self._SSN = SSN
            
        }
        
        if let SelectedzipcodeTxt = applicationModel["SelectedzipcodeTxt"] as? String {
            self._SelectedzipcodeTxt = SelectedzipcodeTxt
            
        }
        
        if let campus = applicationModel["campus"] as? String {
            self._campus = campus
            
        }
        
        if let email = applicationModel["email"] as? String {
            self._email = email
            
        }
        
        if let phone = applicationModel["phone"] as? String {
            self._phone = phone
            
        }
        
        if let userUID = applicationModel["userUID"] as? String {
            self._userUID = userUID
            
        }
        
        if let user_name = applicationModel["user_name"] as? String {
            self._user_name = user_name
            
        }
        
        if let birthday = applicationModel["Birthday"] as? String {
            self._birthday = birthday
            
        }

        
        if let Timestamp = applicationModel["Timestamp"] {
            self._Timestamp = Timestamp
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}
