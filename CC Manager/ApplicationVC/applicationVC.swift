//
//  applicationVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import TTSegmentedControl



enum appMode  {
    
    case new
    case accepted
    case rejected
    
}

class applicationVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

   
    var app = appMode.new
    var insearchMode = false
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var newApplication = [applicationModel]()
    var acceptedApplication = [applicationModel]()
    var rejectedApplication = [applicationModel]()
    var filterList = [applicationModel]()
    //var segmentedC1: TTSegmentedControl = TTSegmentedControl()
    @IBOutlet weak var searchBar: applicationSearchBar!
    var tapGesture: UITapGestureRecognizer!
    
    var email: String!
    var shippingAdd: String!
    
    
    var LicsPlateUrl: String!
    var DriverLics: String!
    var FaceIDUrl: String!
    var SSN: String!
    var car1: String!
    var car2: String!
    var phone: String!
    var user_name: String!
    var uid: String!
    var birthday: String!
    var zipcode: String!
    var state: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
     
        
        
        tapGesture = UITapGestureRecognizer(target: self, action:#selector(applicationVC.closeKeyboard))
        segmentControl.layer.cornerRadius = 0
        segmentControl.layer.borderColor = UIColor.black.cgColor
        segmentControl.layer.borderWidth = 1
        
        //segmentControl.sel
        
        loadNewApplication()
        
    }
    
    
    
    @objc func closeKeyboard() {
        
        self.view.removeGestureRecognizer(tapGesture)
        
        self.view.endEditing(true)
        
        insearchMode = false
        
        tableView.reloadData()
        
        
    }
    
    // search bar
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        
        filterList.removeAll()
        self.view.addGestureRecognizer(tapGesture)
        
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        
        
        
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        insearchMode = false
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        if searchBar.text == nil || searchBar.text == "" {
            
            insearchMode = false
            tableView.reloadData()
            
        } else {
            
            insearchMode = true
            
            
            switch app {
                
            case .new:
                filterList = newApplication.filter({$0.user_name.range(of: searchText) != nil })
            case .accepted:
                filterList = acceptedApplication.filter({$0.user_name.range(of: searchText) != nil })
            case .rejected:
                filterList = rejectedApplication.filter({$0.user_name.range(of: searchText) != nil })
                
            }
            
            tableView.reloadData()
            
            
        }
            
        
        
    }
 
    @IBAction func segmentControlBtnPressed(_ sender: Any) {
        
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            
            
            app = appMode.new
            
            if newApplication.isEmpty != true {
                
                
                
                print("Loaded")
                tableView.reloadData()
                
            } else {
                
                print("Load new")
                loadNewApplication()
                
            }
        case 1:
            
            
            app = appMode.accepted
            
            if acceptedApplication.isEmpty != true {
                
                print("Loaded")
                tableView.reloadData()
                
            } else {
                
                print("Load new")
                loadAcceptedApplication()
                
            }
            
        case 2:
            
            
            app = appMode.rejected
            
            if rejectedApplication.isEmpty != true {
                
                print("Loaded")
                tableView.reloadData()
                
            } else {
                
                print("Load new")
                loadRejectedApplication()
                
            }
            
        default:
            break
        }
        
    }
    
    
    
    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back2BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func loadAcceptedApplication() {
        
        self.acceptedApplication.removeAll()
        self.tableView.reloadData()
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("Accepted").queryOrdered(byChild: "Timestamp").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                if let snap = DriverData.children.allObjects as? [DataSnapshot] {
                    
                    for item in snap {
                        if let postDict = item.value as? Dictionary<String, Any> {
                            
                            let key = DriverData.key
                            let application = applicationModel(postKey: key, applicationModel: postDict)
                            
                            
                            
                            self.acceptedApplication.insert(application, at: 0)
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                
                
                
            }
            
            
        })
        
    }
    
    func loadRejectedApplication() {
        
        
        self.rejectedApplication.removeAll()
        self.tableView.reloadData()
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("Rejected").queryOrdered(byChild: "Timestamp").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                if let snap = DriverData.children.allObjects as? [DataSnapshot] {
                    
                    for item in snap {
                        if let postDict = item.value as? Dictionary<String, Any> {
                            
                            let key = DriverData.key
                            let application = applicationModel(postKey: key, applicationModel: postDict)
                
                            self.rejectedApplication.insert(application, at: 0)
                            
                            
                        }
   
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
            
        })
        
        
    }
   
    
    func loadNewApplication() {
        
        
        self.newApplication.removeAll()
        self.tableView.reloadData()
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").queryOrdered(byChild: "Timestamp").queryLimited(toLast: 20).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                if let snap = DriverData.children.allObjects as? [DataSnapshot] {
                    
                    for item in snap {
                        if let postDict = item.value as? Dictionary<String, Any> {
                            
                            let key = DriverData.key
                            let application = applicationModel(postKey: key, applicationModel: postDict)
                            
                            
                            
                            self.newApplication.insert(application, at: 0)
                            
                            
                        }
                        
                        
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
      
            }
            
        })
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch app {
        case .new:
            if newApplication.isEmpty != true {
                
                tableView.restore()
                return 1
            } else {
                
                tableView.setEmptyMessage("Don't have any new application !!!")
                return 1
                
            }
        case .accepted:
            
            if acceptedApplication.isEmpty != true {
                
                tableView.restore()
                return 1
            } else {
                
                tableView.setEmptyMessage("Don't have any accepted application !!!")
                return 1
                
            }
            
            
        case .rejected:
            
            if rejectedApplication.isEmpty != true {
                
                tableView.restore()
                return 1
            } else {
                
                tableView.setEmptyMessage("Don't have any rejected application !!!")
                return 1
                
            }
            
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        switch app {
        
            
        case .new:
            if insearchMode {
                return filterList.count
            } else {
               return newApplication.count
                
            }
            
        case .accepted:
            
            
            if insearchMode {
                return filterList.count
            } else {
                return acceptedApplication.count
                
            }
            
            
        case .rejected:
            
            if insearchMode {
                return filterList.count
            } else {
                return rejectedApplication.count
                
            }
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var data: applicationModel
        
        switch app {
            
        case .new:
            if insearchMode {
                data = filterList[indexPath.row]
            } else {
                data = newApplication[indexPath.row]
                
            }
        case .accepted:
            if insearchMode {
                data = filterList[indexPath.row]
            } else {
                data = acceptedApplication[indexPath.row]
                
            }
        case .rejected:
            if insearchMode {
                data = filterList[indexPath.row]
            } else {
                data = rejectedApplication[indexPath.row]
                
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell") as? ApplicationCell {
            
            if indexPath.row != 0 {
                
                let lineFrame = CGRect(x:0, y:-20, width: self.view.frame.width, height: 40)
                let line = UIView(frame: lineFrame)
                line.backgroundColor = UIColor.groupTableViewBackground
                cell.addSubview(line)
                
            }
            
            cell.configureCell(data)
            
            
            return cell
            
        } else {
            
            return ApplicationCell()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        switch app {
            
        case .new:
            let item = newApplication[indexPath.row]
            
            email = item.email
            
            if item.Selectedadd2Txt != "nil" {
                
                shippingAdd = "\(item.Selectedadd1Txt!), \(item.Selectedadd2Txt!), \(item.SelectedCityTxt!), \(item.SelectedzipcodeTxt!), \(item.SelectedStateTxt!)"
                
            } else {
                
                
                shippingAdd = "\(item.Selectedadd1Txt!), \(item.SelectedCityTxt!), \(item.SelectedzipcodeTxt!), \(item.SelectedStateTxt!)"
                
                
            }
            
            
            
            LicsPlateUrl = item.LicPlatedownloadUrl
            DriverLics = item.DriverLics
            FaceIDUrl = item.FaceIDdownloadUrl
            car1 = item.Car1downloadUrl
            car2 = item.Car2downloadUrl
            phone = item.phone
            user_name = item.user_name
            uid = item.userUID
            SSN = item.SSN
            birthday = item.birthday
            zipcode = item.SelectedzipcodeTxt
            state = item.SelectedStateTxt
            

            
            self.performSegue(withIdentifier: "moveToDetailVC", sender: nil)
        case .accepted:
            print("accepted")
        case .rejected:
            print("rejected")
            
        }
        
        
        
        
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "moveToDetailVC"{
            if let destination = segue.destination as? applicationDetailVC
            {
                destination.email = email
                destination.shippingAdd = shippingAdd
                destination.LicsPlateUrl = LicsPlateUrl
                destination.DriverLics = DriverLics
                destination.FaceIDUrl = FaceIDUrl
                destination.car1 = car1
                destination.car2 = car2
                destination.phone = phone
                destination.user_name = user_name
                destination.uid = uid
                destination.SSN = SSN
                destination.birthday = birthday
                destination.zipcode = zipcode
                destination.state = state
            }
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
        self.view.endEditing(true)
        
        
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
         self.view.endEditing(true)
    }


}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    func restore() {
        self.backgroundView = nil
        
    }
}
