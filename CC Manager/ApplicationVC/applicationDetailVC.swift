//
//  applicationDetailVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import Cache
import Alamofire
import AlamofireImage
import SwiftyJSON



class applicationDetailVC: UIViewController {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var birthdayLbl: UILabel!
    
    @IBOutlet weak var DriverLicsLbl: UILabel!
    @IBOutlet weak var SSNLabel: UILabel!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var LicsPlateImg: UIImageView!
    @IBOutlet weak var driverLicsImg: UIImageView!
    @IBOutlet weak var ssImg: UIImageView!
    @IBOutlet weak var car1Img: UIImageView!
    
    @IBOutlet weak var car2Img: UIImageView!
    
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    
    var email: String!
    var shippingAdd: String!
    var firstName: String?
    var lastName: String?
    
    
    var SSN: String!
    var LicsPlateUrl: String!
    var DriverLics: String!
    var FaceIDUrl: String!
    var car1: String!
    var car2: String!
    var phone: String!
    var user_name: String!
    var uid: String!
    var birthday: String!
    var zipcode: String!
    var state: String!
    
    @IBOutlet weak var afterCheckBtn: UIStackView!
    @IBOutlet weak var checkView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        shippingLbl.text = shippingAdd
        emailLbl.text = email
        SSNLabel.text = convertIntoSSN(raw: SSN!)
        birthdayLbl.text = birthday
        loadLicsPlate()
        loadDriverLics()
        loadFaceID()
        loadcar1()
        loadcar2()
        checkifcheckrrequest()
        
        
        
       
    }
    
    
    func loadLicsPlate() {
        
    
        
        
        if let ImageCached = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: LicsPlateUrl!).image {

            LicsPlateImg.image = ImageCached
            
            
        } else {
            
            
            Alamofire.request(LicsPlateUrl).responseImage { response in
                
                if let image = response.result.value {
                    
                    let wrapper = ImageWrapper(image: image)
                    try? InformationStorage?.setObject(wrapper, forKey: self.LicsPlateUrl)
                    self.LicsPlateImg.image = image
                    
                }
                
            }
            
            
            
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if previewImg.isHidden != true {
            
            blurView.isHidden = true
            previewImg.isHidden = true
            previewImg.image = nil
            
        }
        
        
        
    }
    
    
    func get_checkr_uid() {
        
        swiftLoader()
        SwiftLoader.show(title: "Screening candidate", animated: true)
        Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Create_Profile").observeSingleEvent(of: .value, with: { (profile) in
            
            if profile.exists() {
                
                
                if let pf = profile.value as? Dictionary<String, AnyObject> {
                    
                    if let id = pf["check-r-uid"] as? String {
                        
                        self.screenCandidate(id: id)
                        
                    }
                }
                
            } else {
                
                self.showErrorAlert("Ops !!!", msg: "There are some issues when creating a candidate profile so we can't do a screen right now, please contact developer at email kn1026@wildcats.unh.edu for more support")
            }
        
            
        })
        
    }

    func loadDriverLics() {

        
        DriverLicsLbl.text = DriverLics
        
    }
    
    func loadFaceID() {
        
        
        if let ImageCached = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: FaceIDUrl!).image {
            
            ssImg.image = ImageCached
            
            
        } else {
            
            
            Alamofire.request(FaceIDUrl).responseImage { response in
                
                if let image = response.result.value {
                    
                    let wrapper = ImageWrapper(image: image)
                    try? InformationStorage?.setObject(wrapper, forKey: self.FaceIDUrl)
                    self.ssImg.image = image
                    
                }
                
            }
            
            
            
            
            
        }
        
        
    }
    
    func loadcar1() {
        
        
        if let ImageCached = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: car1!).image {
            
            car1Img.image = ImageCached
            
            
        } else {
            
            
            Alamofire.request(car1).responseImage { response in
                
                if let image = response.result.value {
                    
                    let wrapper = ImageWrapper(image: image)
                    try? InformationStorage?.setObject(wrapper, forKey: self.car1)
                    self.car1Img.image = image
                    
                }
                
            }
            
            
            
            
            
        }
        
        
    }
    
    func loadcar2() {
        
        
        if let ImageCached = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: car2!).image {

            car2Img.image = ImageCached
            
            
        } else {
            
            
            Alamofire.request(car2).responseImage { response in
                
                if let image = response.result.value {
                    
                    let wrapper = ImageWrapper(image: image)
                    try? InformationStorage?.setObject(wrapper, forKey: self.car2)
                    self.car2Img.image = image
                    
                }
                
            }
            
            
            
            
            
        }
        
        
    }
    
    //ca_DWkdLOAvNorIOTz9TNDMsOjGOVq94jbJ
    
    func create_Stripe_Connect_Account_Driver(email: String) {
        
        let url = MainAPIClient.shared.baseURLString
        let urls = URL(string: url!)?.appendingPathComponent("External_Account")
        
        Alamofire.request(urls!, method: .post, parameters: [
            
            "email": email
            
            ])
            
            .validate(statusCode: 200..<500)
            .responseJSON { responseJSON in
                
                switch responseJSON.result {
                    
                case .success(let json):
                    
                    if let dict = json as? [String: AnyObject] {
                        
                        if let id = dict["id"] as? String {
                            
                            print(id)
                            
                        }
                        
                        print(dict)
                        
                        
                    }
                    
                    
                case .failure(let error):
                    print(error)
                    
                }
                
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard Auth.auth().currentUser != nil else {
            
            self.performSegue(withIdentifier: "GoBackToSignInVC", sender: nil)
            
            return
            
        }
        
        
    }
    @IBAction func acceptBtnPressed(_ sender: Any) {
        
        
        
        print("Accepted")
        
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").child(uid).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                if let Fdata = DriverData.value as? Dictionary<String, Any> {
                    
                    
                    var data = Fdata
                    
                    data["Timestamp"] = ServerValue.timestamp()
                    
                    //self.create_Stripe_Connect_Account_Driver(email: self.email)
                    
                    
                    
                    
                    let Application: Dictionary<String, AnyObject> = ["Car_model": "LX 570" as AnyObject, "Car_registration": "CC1235" as AnyObject, "Timestamp": ServerValue.timestamp() as AnyObject, "UID": self.uid as AnyObject, "birthday": "1997" as AnyObject, "email": self.email as AnyObject, "phone": self.self.phone as AnyObject, "user_name": self.user_name as AnyObject, "FaceUrl": self.FaceIDUrl as AnyObject]
                    
       
                    Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").child(self.uid).removeValue()
                    
                    Database.database().reference().child("Campus-Connect").child("Application_Request").child("Accepted").child(self.uid).setValue(data)
                    
                    Database.database().reference().child("Campus-Connect").child("Driver_Info").child(self.uid).setValue(Application)
                    
                    self.dismiss(animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
            } else {
                
                
                print("Not found")
                
                
            }
            
            
        })
        
        
    }
    @IBAction func carImg1BtnPressed(_ sender: Any) {
        
        previewImg.isHidden = false
        blurView.isHidden = false
        previewImg.image = car1Img.image
        
        
    }
    @IBAction func carImg2BtnPressed(_ sender: Any) {
        
        previewImg.isHidden = false
        blurView.isHidden = false
        previewImg.image = car2Img.image
        
    }
    @IBAction func faceImgIdBtnPressed(_ sender: Any) {
        
        previewImg.isHidden = false
        blurView.isHidden = false
        previewImg.image = ssImg.image
        
    }
    @IBAction func LicsPlateBtnPressed(_ sender: Any) {
        
        previewImg.isHidden = false
        blurView.isHidden = false
        previewImg.image = LicsPlateImg.image
        
    }
    
    func swiftLoader() {
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 170
        
        config.backgroundColor = UIColor.white
        config.spinnerColor = UIColor.black
        config.titleTextColor = UIColor.darkGray
        
        config.spinnerLineWidth = 5.0
        config.foregroundColor = UIColor.black
        config.foregroundAlpha = 0.7
        config.speed = 6
        
        
        SwiftLoader.setConfig(config: config)
        
        
        SwiftLoader.show(title: "", animated: true)
        
    }
    
    @IBAction func rejectBtnPressed(_ sender: Any) {
     
        print("Rejected")
        
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").child(uid).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                if let Fdata = DriverData.value as? Dictionary<String, Any> {
                
                    var data = Fdata
                    
                    data["Timestamp"] = ServerValue.timestamp()
    
                    Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").child(self.uid).removeValue()
                    
                    Database.database().reference().child("Campus-Connect").child("Application_Request").child("Rejected").child(self.uid).setValue(data)
                    
                   
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
                
            } else {
                
                
                print("Not found")
                
                
            }
            
            
        })
        
    }
    
    @IBAction func ViewDetailBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToDetailCheckRVC", sender: nil)
        
    }
    
    func createCandidate() {
        
        swiftLoader()
        SwiftLoader.show(title: "Creating candidate", animated: true)
        
        if let name = user_name {
            
            Database.database().reference().child("Campus-Connect").child("check_r_key").observeSingleEvent(of: .value, with: { (profile) in
                
                if profile.exists() {
                    
                    
                    if let pf = profile.value as? Dictionary<String, AnyObject> {
                        
                        if let key = pf["key"] as? String {
                            
                            let fullNameArr = name.components(separatedBy: " ")
                            
                            
                            self.firstName = fullNameArr[0]
                            self.lastName = fullNameArr[(fullNameArr.count) - 1]
                            
                            
                            self.phone.remove(at: self.phone.startIndex)
                            self.phone.remove(at: self.phone.startIndex)
                            
                            
                            self.SSN = self.convertIntoSSN(raw: self.SSN!)
                            
                            let url = MainAPIClient.shared.baseURLString
                            let urls = URL(string: url!)?.appendingPathComponent("checkRCreateCandidate")
                            
                            
                            Alamofire.request(urls!, method: .post, parameters: [
                                
                                "YOUR_TEST_API_KEY": key,
                                "first_name": self.firstName!,
                                "middle_name": "",
                                "last_name": self.lastName!,
                                "email": self.email!,
                                "phone": self.phone,
                                "zipcode": self.zipcode!,
                                "ssn": self.SSN!,
                                "dob": self.birthday!,
                                "driver_license_number": self.DriverLics!,
                                "State": self.state!
                                
                                ])
                                
                                .validate(statusCode: 200..<500)
                                .responseJSON { responseJSON in
                                    
                                    switch responseJSON.result {
                                        
                                    case .success(let json):
                                        
                                        
                                        
                                        if let dict = json as? [String: AnyObject] {
                                            
                                            if dict["error"] != nil {
                                                SwiftLoader.hide()
                                                self.showErrorAlert("Ops !!!", msg: "Duplicated ssn with another candidate or maybe due to duplicated tap!!!")
                                                
                                            } else {
                                                
                                                if let id =  dict["id"] as? String {
                                                    SwiftLoader.show(title: "Screening candidate", animated: true)
                                                    self.screenCandidate(id: id)
                                                    Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Create_Profile").setValue(["UID": self.uid, "Timestamp": ServerValue.timestamp(), "check-r-uid": id, "Progress": "Created profile"])
                                                    
                                                } else {
                                                    SwiftLoader.hide()
                                                    self.showErrorAlert("Ops !!!", msg: "Error when getting id from candidate for checking process, please try again or contact kn1026@wildcats.unh.edu for more information")
                                                }
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    case .failure( _):
                                        SwiftLoader.hide()
                                        self.showErrorAlert("Ops !!!", msg: "Error when creating candidate for checking process, please try again or contact kn1026@wildcats.unh.edu for more information")
                                        
                                        
                                    }
                                    
                                    
                            }
                            
                            
                        }
                    }
                    
                } else {
                    
                    self.showErrorAlert("Ops !!!", msg: "There are some issues when creating a candidate profile so we can't do a screen right now, please contact developer at email kn1026@wildcats.unh.edu for more support")
                }
                
                
            })
            
            
            
        }
        
        
        
        
    }
    
    func convertIntoSSN(raw: String) -> String {
        
        
        
        if raw.count == 9 {
            
            var count = 0
            var arr = [String]()
            let fullSSNArr = Array(raw)
            
            for i in fullSSNArr {
                
                if count == 3 || count == 5 {
                    arr.append("-")
                    arr.append(String(i))
                } else {
                    arr.append(String(i))
                }
                count += 1
                
                
            }
            
            
            
            return String(arr.joined())
            
        } else {
            
            return "Error converting SSN due to invalid SSN format"
            
        }
        
        
        
    }
    
    func screenCandidate(id: String) {
        
        
        let url = MainAPIClient.shared.baseURLString
        let urls = URL(string: url!)?.appendingPathComponent("checkRScreeningCandidate")
        
        Alamofire.request(urls!, method: .post, parameters: [
            
            "id": id,
            "driver_license_number": DriverLics!,
            "State": state!
            
            ])
            
            .validate(statusCode: 200..<500)
            .responseJSON { responseJSON in
                
                switch responseJSON.result {
                    
                case .success(let json):
                    
                    
                    
                    if let dict = json as? [String: AnyObject] {
                        
                        if dict["error"] != nil {
                            SwiftLoader.hide()
                            self.showErrorAlert("Ops !!!", msg: "Error while requesting screening for current \(id) candidate !!!")
                            
                        } else {
                            
                            
                            if let id = dict["id"] as? String, let object = dict["object"] as? String,  let uri = dict["uri"] as? String, let status = dict["status"] as? String, let created_at = dict["created_at"] as? String, let due_time = dict["due_time"] as? String, let package = dict["package"] as? String, let candidate_id = dict["candidate_id"], let global_watchlist_search_id = dict["global_watchlist_search_id"] as? String, let national_criminal_search_id = dict["national_criminal_search_id"] as? String, let sex_offender_search_id = dict["sex_offender_search_id"] as? String, let ssn_trace_id = dict["ssn_trace_id"] as? String, let terrorist_watchlist_search_id = dict["terrorist_watchlist_search_id"] as? String, let motor_vehicle_report_id = dict["motor_vehicle_report_id"] as? String
                                
                            {
                                
                                Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Screening_candidate").setValue(["UID": self.uid, "Timestamp": ServerValue.timestamp(), "check-r-uid": id, "Progress": "Request screening report"])
                                Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Screening_detail").setValue(["UID": self.uid, "Timestamp": ServerValue.timestamp(), "id": id, "object": object, "uri": uri, "status": status, "created_at": created_at, "due_time": due_time, "package": package, "candidate_id": candidate_id, "global_watchlist_search_id": global_watchlist_search_id, "national_criminal_search_id": national_criminal_search_id, "sex_offender_search_id": sex_offender_search_id, "ssn_trace_id": ssn_trace_id, "terrorist_watchlist_search_id": terrorist_watchlist_search_id, "motor_vehicle_report_id": motor_vehicle_report_id])
                                self.showErrorAlert("Done !!!", msg: "Succesfully request candidate report, there will be notification whether the status of the order change for '\(id)' candidate")
                                self.detailBtn.isHidden = false
                            } else {
                                self.showErrorAlert("Ops !!!", msg: "Unkown error occur when casting data - 303")
                            }
                            
                            SwiftLoader.hide()
                            
                            
                        }
                        
                        
                    }
                    
                case .failure( _):
                    SwiftLoader.hide()
                    self.showErrorAlert("Ops !!!", msg: "Error when screening candidate for checking process, please try again or contact kn1026@wildcats.unh.edu for more information")
                    
                    
                }
                
                
        }
        
        
    }
    
    
    func checkifcheckrrequest() {
        
        Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Create_Profile").observeSingleEvent(of: .value, with: { (profile) in
            
            if profile.exists() {
                
                Database.database().reference().child("Campus-Connect").child("check-r").child(self.uid).child("Screening_candidate").observeSingleEvent(of: .value, with: { (screening) in
                    
                    if screening.exists() {
                        
                        self.afterCheckBtn.isHidden = false
                        self.checkView.isHidden = true
                        self.detailBtn.isHidden = false
                        
                    } else {
                        
                        
                        self.checkBtn.setTitle("Screen", for: .normal)
                        self.afterCheckBtn.isHidden = true
                        self.checkView.isHidden = false
                        self.detailBtn.isHidden = true
                        
                    }
                    
                    
                })
                
                
            } else {
                
                self.checkBtn.setTitle("Create profile", for: .normal)
                
                self.afterCheckBtn.isHidden = true
                self.checkView.isHidden = false
                self.detailBtn.isHidden = true
                
                
            }
            
        })
        
    }
    
    @IBAction func checkBtnPressed(_ sender: Any) {
        
        
        
        if checkBtn.titleLabel?.text == "Create profile"{
            
            createCandidate()
            
        } else if checkBtn.titleLabel?.text == "Screen" {
            
            get_checkr_uid()
            
            
        } else {
            
            self.showErrorAlert("Ops !!", msg: "Bug found")
        }
        
        
        
        
        
    }
    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func back2BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "moveToDetailCheckRVC"{
            if let destination = segue.destination as? Checkr_detailVC
            {
               
                destination.uid = uid
               
            }
        }
    }
    
    
    
}


struct SSN {
    // Stores aaa-bb-ccc as aaabbbccc
    let ssn: UInt32
    
    init?(_ string: String) {
        let segments = string.split(separator: "-")
        
        guard segments.lazy.map({ $0.count }) == [3, 2, 3] else {
            debugPrint("SSN segments must be lenght 3, 2, 3 (e.g. 123-45-678).")
            return nil
        }
        
        
        guard !zip(segments, ["000", "00", "000"]).contains(where: {$0.0 == $0.1}) else {
            debugPrint("SSN segments cannot be all zeros.")
            return nil
        }
        
        let firstSegment = segments[0]
        guard firstSegment != "666", !firstSegment.hasPrefix("9") else {
            debugPrint("The first SSN segment (\(firstSegment)) cannot be 666, or be in the range 900-999.")
            return nil
        }
        let dashesRemoved = string.replacingOccurrences(of: "-", with: "")
        
        self.ssn = UInt32(dashesRemoved)!
    }
}

extension SSN: ExpressibleByStringLiteral {
    init(stringLiteral literalString: String) {
        self.init(literalString)!
    }
}
