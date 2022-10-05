//
//  RegisterFixer.swift
//  IronBike
//
//  Created by MUYANGO Gael SHEMA on 10/04/2019.
//  Copyright © 2019 Fontys. All rights reserved.
//

import UIKit
import Firebase
class RegisterFixer: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let ref = Database.database().reference()
    var userUID = Auth.auth().currentUser;
    let position = "fixer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
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
    
    
    /* IBAction  func button to register new fixer account*/

    @IBAction func fixerSignUp(_ sender: AnyObject) {
        let email = self.emailField!.text
        let password = self.passwordField!.text
        let name = self.nameField!.text
        
        Auth.auth().createUser(withEmail: email! , password: password!) { user, error in
            if error==nil{
                Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!);
                
                let users = Users(name: name!,position : self.position)
                let usersRef = self.ref.child("users").child("fixers").child((self.userUID?.uid)!)
                usersRef.setValue(users.toAnyObject());
            }
        };
    }
}
