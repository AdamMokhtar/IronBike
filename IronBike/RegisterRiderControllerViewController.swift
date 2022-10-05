//
//  RegisterRiderControllerViewController.swift
//  IronBike
//
//  Created by MUYANGO Gael SHEMA on 22/03/2019.
//  Copyright © 2019 Fontys. All rights reserved.
//

import UIKit
import Firebase

class RegisterRiderControllerViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    let rentSegue = "renterDashboard"
    let ref = Database.database().reference()
    var userUID = Auth.auth().currentUser;
    let position = "rider"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /** Make the Keyboard disappear when touching outside it */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func riderSignUp(_ sender: AnyObject) {
        let emailField = self.textFieldEmail!.text
        let passwordField = self.textFieldPassword!.text
        let nameField = self.textFieldName!.text
        
        Auth.auth().createUser(withEmail: emailField! , password: passwordField!) { user, error in
            if error==nil{
                Auth.auth().signIn(withEmail: self.textFieldEmail.text!, password: self.textFieldPassword.text!);
                
                let users = Users(name: nameField!,position : self.position)
                let usersRef = self.ref.child("users").child("riders").child((self.userUID?.uid)!)
                usersRef.setValue(users.toAnyObject());
            }
        };
    }
}
