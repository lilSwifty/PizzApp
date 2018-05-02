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
    @IBOutlet weak var passwordAgain: UITextField!
    @IBOutlet weak var registerAgainBtn: UIButton!
    
    var activityindicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.message.alpha = 0.0
        self.passwordAgain.isHidden = true
        self.registerAgainBtn.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        self.message.alpha = 0.0
        startSpinning()
        
        print("before")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopSpinning()
            self.login()
            
        }
        
    }
    
    func login(){
        
        
        
        Auth.auth().signIn(withEmail: email.text!, password: password
            .text!) { (user, error) in
                if error != nil {
                    self.message.text = "Inloggning misslyckades"
                    self.message.alpha = 1.0
                } else if user != nil {
                    self.performSegue(withIdentifier: "userLogged", sender: self)
                    self.password.text = ""
                    print(user!)
                }
        }
        

    }
    
    func startSpinning(){
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(activityindicator)
        
        activityindicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopSpinning(){
        self.activityindicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    @IBAction func confirmRegistration(_ sender: UIButton) {
        confirmationOfRegistretation()
    }
    
    @IBAction func register(_ sender: UIButton) {
        self.passwordAgain.isHidden = false
        self.registerAgainBtn.isHidden = false
    }
    
    func confirmationOfRegistretation(){
        if password.text == passwordAgain.text {
            self.message.alpha = 0.0
            
            startSpinning()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                
                Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!){
                    (user, error) in
                    
                    if error != nil{
                        
                        Auth.auth().fetchProviders(forEmail: self.email.text!, completion: {
                            (providers, error) in
                            
                            if let error = error {
                                self.stopSpinning()
                                print(error)
                                self.message.text = "Registrering misslyckades"
                                UIView.animateKeyframes(withDuration: 1.0, delay: 0.5, animations: {self.message.alpha = 1.0})
                            } else if let providers = providers {
                                self.stopSpinning()
                                self.message.text = "Användare finns redan"
                                UIView.animateKeyframes(withDuration: 1.0, delay: 0.5, animations: {self.message.alpha = 1.0})
                                print(providers)
                            }
                        })
                        
                        
                    } else {
                        self.stopSpinning()
                        print("Registrering genomförd!")
                        UIView.animateKeyframes(withDuration: 1.0, delay: 2.0, animations: {self.message.alpha = 1.0})
                        UIView.animateKeyframes(withDuration: 3.0, delay: 3.0, animations: {self.message.alpha = 0.0})
                        self.password.text = ""
                        self.passwordAgain.isHidden = true
                        self.registerAgainBtn.isHidden = true
                    }
                }
                print("inside delay")
            }
        } else {
            print("registration failed, passwords don't match")
            let ac = UIAlertController(title: "Felaktig lösenord", message: "Kontrollera att lösenorden överrensstämmer", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
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
