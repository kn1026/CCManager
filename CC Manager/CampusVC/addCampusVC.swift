
//
//  addCampusVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 3/31/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MobileCoreServices
import AVKit
import AVFoundation
import Firebase
import GeoFire


class addCampusVC: UIViewController, GMSMapViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var logoSchool: UIImageView!
    @IBOutlet weak var radiusField: modTxtField!
    @IBOutlet weak var priceField: modTxtField!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var CampusLbl: UILabel!
    var tapGesture: UITapGestureRecognizer!
    
    var lat: CLLocationDegrees!
    var lon: CLLocationDegrees!
    
    var photo: UIImage!
    
    
    let autocompleteController = GMSAutocompleteViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tapGesture = UITapGestureRecognizer(target: self, action:#selector(campusDetail.closeKeyboard))
        
        priceField.delegate = self
        radiusField.delegate = self
        priceField.keyboardType = .numbersAndPunctuation
        
        
        
        mapView.isUserInteractionEnabled = false
        mapView.delegate = self
        autocompleteController.delegate = self
        styleMap()
        
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

    
    func drawMap(lon: CLLocationDegrees, lat: CLLocationDegrees){
        
        
        
        mapView.clear()
        
        let marker = GMSMarker()
        
        
        let cordinated = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        // get MapView
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
        let cam = GMSCameraUpdate.setCamera(camera)
        
        //mapV
        
        
        marker.position = cordinated
        marker.map = mapView
        
        
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
        
        //self.mapView.camera = camera
        self.mapView.moveCamera(cam)
        
        
        
        
        
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
        
        
        SwiftLoader.show(title: "Creating campus", animated: true)
        
    }
    
    @objc func closeKeyboard() {
        
        self.view.removeGestureRecognizer(tapGesture)
        
        self.view.endEditing(true)
        
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -220, up: true)
        self.view.addGestureRecognizer(tapGesture)
        
        
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
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        moveTextField(textField, moveDistance: -220, up: false)
        
        
        
        
    }
    
    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back2BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func addCampusNameBtnPressed(_ sender: Any) {
        
        self.present(autocompleteController, animated: true, completion: nil)
        
    }
    
    
    func uploadLogo(image: UIImage, price: String, domain: String, name: String) {
        
        let metaData = StorageMetadata()
        let imageUID = UUID().uuidString
        metaData.contentType = "image/jpeg"
        var imgData = Data()
        imgData = UIImageJPEGRepresentation(image, 1.0)!
        
        DataService.instance.AvatarStorageRef.child(imageUID).putData(imgData, metadata: metaData) { (meta, err) in
            
            if err != nil {
                
                SwiftLoader.hide()
                self.showErrorAlert("Oopss !!!", msg: "Error while saving your image, please try again")
                print(err?.localizedDescription as Any)
                
            } else {
                
                DataService.instance.AvatarStorageRef.child(imageUID).downloadURL(completion: { (url, err) in
                    
                    
                    guard let Url = url?.absoluteString else { return }
                    
                    let downUrl = Url as String
                    let downloadUrl = downUrl as NSString
                    let downloadedUrl = downloadUrl as String
                    
                    self.uploadCampusInformation(url: downloadedUrl, price: price, domain: domain, name: name)
                    
                    
                    
                    
                   
                    
                })
                
                
                
                
                
            }
            
            
        }
        
        
    }
    
    func uploadCampusInformation(url: String, price: String, domain: String, name: String) {
        
        var names = name
        if name == "UMASS / Amherst" {
            names = "UMass Amherst"
        }
        if name == "Main st + Clark University" {
            names = "Clark University"
        }
    Database.database().reference().child("Campus-Connect").child("Available_Campus").child(names).setValue(["Domain": domain, "Price": Float(price)!, "Timestamp": ServerValue.timestamp(), "Url": url])
        
        
        let geoFireUrl = Database.database().reference().child("Campus-Connect").child("Campus_Coordinate")
        let geofireRef = geoFireUrl
        let geoFire = GeoFire(firebaseRef: geofireRef)
        
        geoFire.setLocation(CLLocation(latitude: lat, longitude: lon), forKey: names)
        
        
        let ref = Database.database().reference().child("Campus-Connect").child("Available_Campus").child(names).childByAutoId()
        
        
        let key = ref.key
        Database.database().reference().child("Campus-Connect").child("Available_Campus").child(names).updateChildValues(["Key": key!])
        
        SwiftLoader.hide()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
        self.getMediaFrom(kUTTypeImage as String)
        
    }
    @IBAction func DoneBtnPressed(_ sender: Any) {
        
        if let price = priceField.text, price != "", photo != nil, let campus = CampusLbl.text, campus != "Campus Name", let domain = radiusField.text, domain != "", domain.contains("@") == true, domain.contains(".") {
            
            swiftLoader()
            uploadLogo(image: photo, price: price, domain: domain, name: campus)
            
            
        } else{
            
            self.showErrorAlert("Ops !!!", msg: "Please enter college's name, price, domain and logo picture to continue.")
        }
        
    }
    
    func getImage(image: UIImage) {
        
        logoSchool.image = image
        photo = image
        
        
    }
    
    
    //func show error alert
    
    func showErrorAlert(_ title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    // get media
    
    func getMediaFrom(_ type: String) {
        let mediaPicker = UIImagePickerController()
        mediaPicker.delegate = self
        mediaPicker.allowsEditing = false
        mediaPicker.mediaTypes = [type as String]
        self.present(mediaPicker, animated: true, completion: nil)
    }
    
    
}

extension addCampusVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let placed = place.name
        
        
        CampusLbl.text = placed
        
        self.lat = place.coordinate.latitude
        self.lon = place.coordinate.longitude
        
        drawMap(lon: lon, lat: lat)

        
        dismiss(animated: true, completion: nil)
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
    
}


extension addCampusVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            getImage(image: editedImage)
        } else if let originalImage =
            info["UIImagePickerControllerOriginalImage"] as? UIImage {
            getImage(image: originalImage)
        } else {
            print("Bug found")
        }
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
}

