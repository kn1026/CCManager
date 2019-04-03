//
//  campusVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/31/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase

class campusVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var uniName: String!
    var SchoolArr = [CampusModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestAvailableCampus()
        
    }
    
    func requestAvailableCampus() {
        SchoolArr.removeAll()
        Database.database().reference().child("Campus-Connect").child("Available_Campus").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if let snap = DriverData.children.allObjects as? [DataSnapshot] {
                
                for item in snap {
                    if let postDict = item.value as? Dictionary<String, Any> {
                        
                        var dt = postDict
                        dt.updateValue(item.key, forKey: "Name")
                        
                        let SchoolDataResult = CampusModel(postKey: item.key, schoolModel: dt)
                        
                        self.SchoolArr.append(SchoolDataResult)
                        
                        self.tableView.reloadData()
                        
                    }
                }
                
            }
            
            
        })
        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SchoolArr.count
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = SchoolArr[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "campusCell") as? campusCell {
            
         
            
            cell.configureCell(data)
            
            return cell
            
        } else {
            
            return campusCell()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let item = SchoolArr[indexPath.row]
        uniName = item.Name
        self.performSegue(withIdentifier: "moveToCampusDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "moveToCampusDetailVC"{
            if let destination = segue.destination as? campusDetail
            {
                destination.uniName = uniName
            }
        }
    }
    @IBAction func addNewCampusBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToAddCampusVC", sender: nil)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        
        //campusCell
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backBtn1Pressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
