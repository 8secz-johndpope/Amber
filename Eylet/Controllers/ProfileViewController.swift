//
//  ProfileViewController.swift
//  Eylet
//
//  Created by Temporary on 3/13/20.
//  Copyright © 2020 Temporary. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class ProfileViewController: UIViewController, UITextFieldDelegate, ImagePickerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: ImagePicker!
    

    @IBOutlet weak var imageViewButton: UIButton!
    
    @IBAction func saveButton(_ sender: Any) {
        defaults.set(nameField.text, forKey: "name")
        defaults.set(emailField.text, forKey: "email")
        defaults.set(ageField.text, forKey: "age")
        defaults.set(budgetField.text, forKey: "budget")
    }
    
    
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        view.addGestureRecognizer(tap)
        
        nameField.delegate = self
        emailField.delegate = self
        ageField.delegate = self
        budgetField.delegate = self
        
        backgroundView.layer.cornerRadius = 15
        if defaults.value(forKey: "name") == nil {
            nameField.placeholder = "Full name"
            nameField.textColor = UIColor.lightGray
        } else {
            nameField.text = defaults.value(forKey: "name") as? String
        }
        
        if defaults.value(forKey: "email") == nil {
            emailField.placeholder = "Email"
            emailField.textColor = UIColor.lightGray
        } else {
            emailField.text = defaults.value(forKey: "email") as? String
        }
        
        if (defaults.value(forKey: "age")==nil){
            ageField.placeholder = "Age"
            ageField.textColor = UIColor.lightGray
        }
        else{
            ageField.text = defaults.value(forKey: "age") as? String
        }

        if (defaults.value(forKey: "budget") == nil){
            budgetField.placeholder = "Budget"
            budgetField.textColor = UIColor.lightGray
        }
        else{
            budgetField.text = defaults.value(forKey: "budget") as? String
        }
        if (defaults.value(forKey: "profile") != nil) {
            imageView.image = getImageFromUserDefault(key: "profile")

        }
        
        
        nameLabel.font = UIFont(name: "Helvetica", size: 14)
        
        emailLabel.font = UIFont(name: "Helvetica", size: 14)
        
        ageLabel.font = UIFont(name: "Helvetica", size: 14)
        
        budgetLabel.font = UIFont(name: "Helvetica", size: 14)
         
        saveButton = setupButtons(text: "Save") as? StyledButton
        
        imageView.layer.cornerRadius =  80
    }
    
   
    
    func setupButtons(text: String) -> UIButton{
        let buttons = StyledButton(type: .custom)
        buttons.style = .gradient(startColor: .lightGray, endColor: .lightGray)
        buttons.setTitle(text, for: .normal)
       return buttons
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func swipeToRight(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func imageViewButton(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIView)
        self.imageViewButton.backgroundColor = .clear
        
    }
    
    func didSelect(image: UIImage?) {
        let newImage = image?.rounded(radius: 480)
          self.imageView.image = newImage
        saveImageInUserDefault(img: image!, key: "profile")
      }
    
    func saveImageInUserDefault(img:UIImage, key:String) {
        UserDefaults.standard.set(img.pngData(), forKey: key)
    }

    func getImageFromUserDefault(key:String) -> UIImage? {
        let imageData = UserDefaults.standard.object(forKey: key) as? Data
        var image: UIImage? = nil
        if let imageData = imageData {
            image = UIImage(data: imageData)
        }
        return image
    }
}

