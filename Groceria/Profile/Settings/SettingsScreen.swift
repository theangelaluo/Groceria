//
//  SettingsScreen.swift
//  Groceria
//
//  Created by Anna Yang on 6/6/20.
//  Copyright © 2020 Angela Luo. All rights reserved.
//

import UIKit
import Firebase

class SettingsScreen: UIViewController {
    let db = Firestore.firestore()
    
    // Stored information from firebase
    let userID: String = (Auth.auth().currentUser?.uid)!
    var namePerson: String = ""
    var emailPerson: String = ""
    var address1Person: String = ""
    var address2Person: String = ""
    var cityPerson: String = ""
    var statePerson: String = ""
    var zipPerson: String = ""
    var current: String = ""

    // Name + email popup variables
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityStateTextField: UITextField!
    @IBOutlet weak var titleLabelChangePopup: UILabel!
    @IBOutlet var changeProfilePopup: UIView!
    @IBOutlet weak var placeHolderChange: UITextField!
    
    // Address popup variables
    @IBOutlet var changeAddressPopup: UIView!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var changeAddressButton: UIButton!
    
    
    // Delete account from system
    @IBAction func deleteAccount(_ sender: Any) {
        print("Delete account")
        // popup asking to Are you sure you want to delete your account?
    }
    
    // Change Name, Email, Address popups
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))

    // Change Name
    @IBAction func popNameButton(_ sender: Any) {
        current = "name"
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.addSubview(changeProfilePopup)
        changeProfilePopup.center = self.view.center
        popupDesign(current: current)
    }

    // Change Email
    @IBAction func popEmailButton(_ sender: Any) {
        current = "email"
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.addSubview(changeProfilePopup)
        changeProfilePopup.center = self.view.center
        popupDesign(current: current)
    }
    
    // Close address popup
    @IBAction func closeAddressPopup(_ sender: Any) {
        self.changeAddressPopup.removeFromSuperview()
        self.blurView.removeFromSuperview()
    }
    
    // Change address popup
    @IBAction func changeAddress(_ sender: Any) {
        // send address information back to firebase
        print("current: \(current)")
        self.changeAddressPopup.removeFromSuperview()
        self.blurView.removeFromSuperview()
    }
    
    // Popup address
    @IBAction func popAddressButton(_ sender: Any) {
        current = "address"
        blurView.frame = self.view.bounds
        self.view.addSubview(blurView)
        self.view.addSubview(changeAddressPopup)
        changeAddressPopup.center = self.view.center
        
        self.address1TextField.attributedPlaceholder = NSAttributedString(string: self.address1Person)
        self.address2TextField.attributedPlaceholder = NSAttributedString(string: self.address2Person)
        self.cityTextField.attributedPlaceholder = NSAttributedString(string: self.cityPerson)
        self.stateTextField.attributedPlaceholder = NSAttributedString(string: self.statePerson)
        self.zipTextField.attributedPlaceholder = NSAttributedString(string: self.zipPerson)
    
        changeAddressButton.layer.shadowColor = UIColor.black.cgColor
        changeAddressButton.layer.shadowRadius = 2.0
        changeAddressButton.layer.shadowOpacity = 0.7
        changeAddressButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        changeAddressButton.layer.masksToBounds = false
        
        let buttonColor1 = UIColor(red: 82.0/255.0, green: 152.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        let buttonColor2 = UIColor(red: 15.0/255.0, green: 55.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        changeAddressButton.applyGradient(colors: [buttonColor1.cgColor, buttonColor2.cgColor])
    }
    
    // Close button for name and email
    @IBAction func closeProfilePopup(_ sender: Any) {
        self.changeProfilePopup.removeFromSuperview()
        self.blurView.removeFromSuperview()
    }
    
    // Change button for name and email
    @IBAction func changeButtonPopup(_ sender: Any) {
        print("current: \(current)")
        // send information back to firebase
        print(userID)
        self.changeProfilePopup.removeFromSuperview()
        self.blurView.removeFromSuperview()
    }
    
    // Popup for name, email, and address
    func popupDesign (current: String) {
        if current == "name" {
            self.titleLabelChangePopup.text = "Change Name"
            self.placeHolderChange.attributedPlaceholder = NSAttributedString(string: self.namePerson)
        } else if current == "email" {
            self.titleLabelChangePopup.text = "Change Email"
            self.placeHolderChange.attributedPlaceholder = NSAttributedString(string: self.emailPerson)
        }
        
        changeButton.layer.shadowColor = UIColor.black.cgColor
        changeButton.layer.shadowRadius = 2.0
        changeButton.layer.shadowOpacity = 0.7
        changeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        changeButton.layer.masksToBounds = false
        
        let buttonColor1 = UIColor(red: 82.0/255.0, green: 152.0/255.0, blue: 217.0/255.0, alpha: 1.0)
        let buttonColor2 = UIColor(red: 15.0/255.0, green: 55.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        changeButton.applyGradient(colors: [buttonColor1.cgColor, buttonColor2.cgColor])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pull user information
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // grab information and change label placeholders
                self.namePerson = document.data()?["name"] as! String
                self.nameTextField.attributedPlaceholder = NSAttributedString(string: self.namePerson)
                
                self.emailPerson = document.data()?["email"] as! String
                self.emailTextField.attributedPlaceholder = NSAttributedString(string: self.emailPerson)
                
                self.address1Person = document.data()?["address1"] as! String
                self.address2Person = document.data()?["address2"] as! String
                self.cityPerson = document.data()?["city"] as! String
                self.statePerson = document.data()?["state"] as! String
                self.zipPerson = document.data()?["zip"] as! String
                self.cityStateTextField.attributedPlaceholder = NSAttributedString(string: self.cityPerson + ", " + self.statePerson)
            } else {
                print("Document does not exist")
            }
        }
                
        // add borders for cells
        nameView.layer.borderWidth = 0.25
        nameView.layer.borderColor = UIColor.lightGray.cgColor
        addressView.layer.borderWidth = 0.25
        addressView.layer.borderColor = UIColor.lightGray.cgColor
        changePasswordView.layer.borderWidth = 0.25
        changePasswordView.layer.borderColor = UIColor.lightGray.cgColor

    }

}
