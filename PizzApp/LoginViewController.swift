//
//  LoginViewController.swift
//  PizzApp
//
//  Created by Mani Sedighi on 2018-04-30.
//  Copyright © 2018 Mani Sedighi. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.message.alpha = 0.0

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            print(user?.email)
        }
    }
    

    
    @IBAction func register(_ sender: UIButton) {
        
        
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 3.0, animations: {self.message.alpha = 0.0})
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){
            (user, error) in
            
            if error != nil{
                
                Auth.auth().fetchProviders(forEmail: self.email.text!, completion: {
                    (providers, error) in
                    
                    if let error = error {
                        print(error)
                        self.message.text = "Failed to register"
                        UIView.animateKeyframes(withDuration: 1.0, delay: 2.0, animations: {self.message.alpha = 1.0})
                    } else if let providers = providers {
                        self.message.text = "User already exists"
                        UIView.animateKeyframes(withDuration: 1.0, delay: 2.0, animations: {self.message.alpha = 1.0})
                        print(providers)
                    }
                })
                
                
            } else {
                print("Registration successfull!")
                UIView.animateKeyframes(withDuration: 1.0, delay: 2.0, animations: {self.message.alpha = 1.0})
                UIView.animateKeyframes(withDuration: 3.0, delay: 3.0, animations: {self.message.alpha = 0.0})
                self.password.text = ""
            }
        }
        
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
