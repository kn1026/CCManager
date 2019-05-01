//
//  campusDetail.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/31/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import GoogleMaps
import JDropDownAlert
import Foundation
import GeoFire

class campusDetail: UIViewController,GMSMapViewDelegate, UITextFieldDelegate {

    var price: String!
    var old: String!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var baseFareLbl: UITextField!
    @IBOutlet weak var radiusLbl: UITextField!
    @IBOutlet weak var uniNameLbl: UILabel!
    var tapGesture: UITapGestureRecognizer!
    var uniName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        mapView.isUserInteractionEnabled = false
        mapView.delegate = self
        
        baseFareLbl.delegate = self
        radiusLbl.delegate = self
        baseFareLbl.keyboardType = .numbersAndPunctuation
        radiusLbl.keyboardType = .numberPad
        
        tapGesture = UITapGestureRecognizer(target: self, action:#selector(campusDetail.closeKeyboard))
        
        if let name = uniName {
            
            styleMap()
            uniNameLbl.text = name
            getSchoolCoor(uniName: name)
            getSchoolPrice(uniName: name)
        }
        
        
        
    }
    
    @objc func closeKeyboard() {
        
        self.view.removeGestureRecognizer(tapGesture)
        
        self.view.endEditing(true)
        
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -220, up: true)
        self.view.addGestureRecognizer(tapGesture)
        
        old = baseFareLbl.text
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -220, up: false)
        
        
        if baseFareLbl.text != "" {
            
            
            if baseFareLbl.text != old {
                
                if (baseFareLbl.text?.contains("$"))! {
                    
                    
                    price = baseFareLbl.text
                    
                    
                } else {
                    
                    if let num = baseFareLbl.text {
                        
                        
                        baseFareLbl.text = num
                        price = baseFareLbl.text
                        
                        
                    }
                    
                    
                }
                
                
                
                old = nil
                
            } else {
                
                price = nil
                
                
            }
            
            
            
        }
        
        
        
        
        
        
        
        
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Move the text field in a pretty animation!
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func getSchoolCoor(uniName: String) {
        
        Database.database().reference().child("Campus-Connect").child("Campus_Coordinate").child(uniName).child("l").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                if let postDict = DriverData.value as? [CLLocationDegrees] {
                    
                    let lon = postDict[1]
                    let lat = postDict[0]
                    
                    self.drawMap(lon: lon, lat: lat)
                    
                } else{
                    
                    print("Can't convert")
                    
                }
                
            }
            
 
        })
        
        
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
        
        
        SwiftLoader.show(title: "Centering location", animated: true)
        
    }
    
    func centerLocation() {
        
        
        Database.database().reference().child("Campus-Connect").child("Campus_Coordinate").child(uniName).child("l").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                if let postDict = DriverData.value as? [CLLocationDegrees] {
                    
                    let lon = postDict[1]
                    let lat = postDict[0]
                    
                    let geoFireUrl = Database.database().reference().child("Campus-Connect").child("Campus_Coordinate")
                    let geofireRef = geoFireUrl
                    let geoFire = GeoFire(firebaseRef: geofireRef)
                    
                    geoFire.setLocation(CLLocation(latitude: lat, longitude: lon), forKey: self.uniName)
                    
                    SwiftLoader.hide()
                    
                    
                } else{
                    
                    print("Can't convert")
                }
                
            } else {
                
                SwiftLoader.hide()
                self.showErrorAlert("Ops !!!", msg: "Can't find this campus available on database")
                
                
            }
            
            
            
        })
        
        
    }
    
    //func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func styleMap() {
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "customizedMap", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        
        
    }
 
    
    @IBAction func notiBtnPressed(_ sender: Any) {
        
        
        
        Database.database().reference().child("Campus-Connect").child("Request_noti_school").removeValue()
        
        
        
        Database.database().reference().child("Campus-Connect").child("Available_Campus").child(uniNameLbl.text!).observeSingleEvent(of: .value, with: { (schoolData) in
            
            
            if schoolData.exists() {
                
                if let dict = schoolData.value as? Dictionary<String, Any> {
                    
                    
                    if let subKey = dict["Key"] as? String {
                        
                        Database.database().reference().child("Campus-Connect").child("Request_noti_school").child(subKey).setValue([self.uniNameLbl.text!:"1"])
                        
                        
                        }
                        
                    }
                    
            } else {
                print("Can't find school")
            }
                
                
            })
        
        
    }
    
    @IBAction func deleteBtnPressed(_ sender: Any) {
        
        Database.database().reference().child("Campus-Connect").child("Available_Campus").child(uniName).removeValue()
        Database.database().reference().child("Campus-Connect").child("Campus_Coordinate").child(uniName).removeValue()
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    func drawMap(lon: CLLocationDegrees, lat: CLLocationDegrees){
        
    
        
        let marker = GMSMarker()

        
        let cordinated = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        // get MapView
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)

        //mapV
        
        
        marker.position = cordinated
        marker.map = mapView
        
        
        //let circleColor = UIColor(red: 236, green: 100, blue: 76, alpha: 1.0)
        
        
        marker.isTappable = false
        
       let circle = GMSCircle()
        
        circle.position = cordinated
        circle.radius = 16093.4
        circle.strokeWidth = 1.0
        circle.strokeColor = UIColor.blue.withAlphaComponent(0.4)
        circle.fillColor = UIColor.blue.withAlphaComponent(0.1)
        circle.map = mapView
        
        
        
        var img = UIImage(named: "center")
        img = resizeImage(image: img!, targetSize: CGSize(width: 20.0, height: 20.0))
        
        marker.icon = img
        
        self.mapView.camera = camera
        self.mapView.animate(to: camera)
    }
    
    func getSchoolPrice(uniName: String) {
        
        Database.database().reference().child("Campus-Connect").child("Available_Campus").child(uniName).observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                if let postDict = DriverData.value as? Dictionary<String, Any> {
                    
                    if let price = postDict["Price"] {
                        
                        self.baseFareLbl.text = "\(price)"
                        
                    } else {
                        
                        self.baseFareLbl.text = "Error"
                    }
                   
                    
                } else{
                    
                    print("Can't convert")
                }
                
                self.radiusLbl.text = "10"
                
            }
            
      
        })
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func recenterLocationBtn(_ sender: Any) {
        
        swiftLoader()
        centerLocation()
        
        
        
    }
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        
        if price != nil {
                 
            let prices = Double(price)
            var roundedPrice = prices?.roundTo(places: 2)
            
            
            
            
            roundedPrice = (roundedPrice!*100).rounded()/100
            
            
    
            let data = ["Price": roundedPrice!, "Timestamp": ServerValue.timestamp()] as [String : Any]
            
            
            price = nil
            
            
            Database.database().reference().child("Campus-Connect").child("Available_Campus").child(uniName).updateChildValues(data) { (err, data) in
                
                
                if err != nil {
                    
                    
                    let alert = JDropDownAlert()
                    let color = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 0.9)
                    alert.alertWith("Can't save, \(err.debugDescription)",
                                    topLabelColor: UIColor.white,
                                    messageLabelColor: UIColor.white,
                                    backgroundColor: color)
                    
                } else {
                    
                    
                    let alert = JDropDownAlert()
                    
                    let color = UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1.0)
                    alert.alertWith("Successfully saved",
                                    topLabelColor: UIColor.white,
                                    messageLabelColor: UIColor.white,
                                    backgroundColor: color)
                    
                    
                }
                
                
            }
            
            
            
            
            
        } else {
            
            let alert = JDropDownAlert()
            let color = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 0.9)
            alert.alertWith("Can't save",
                            topLabelColor: UIColor.white,
                            messageLabelColor: UIColor.white,
                            backgroundColor: color)
            
            
        }
        
        
    }
    

}

extension Double {
    
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    
    
}


import GoogleMaps
extension GMSCircle {
    func bounds () -> GMSCoordinateBounds {
        func locationMinMax(positive : Bool) -> CLLocationCoordinate2D {
            let sign:Double = positive ? 1 : -1
            let dx = sign * self.radius  / 6378000 * (180/Double.pi)
            let lat = position.latitude + dx
            let lon = position.longitude + dx / cos(position.latitude * Double.pi/180)
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        
        return GMSCoordinateBounds(coordinate: locationMinMax(positive: true),
                                   coordinate: locationMinMax(positive: false))
    }
}
