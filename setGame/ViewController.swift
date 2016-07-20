//
//  ViewController.swift
//  setGame
//
//  Created by KimGyuho on 2016. 7. 14..
//  Copyright © 2016년 KimGyuho. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, GADBannerViewDelegate {

    
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-8906718373249690/5709759361"
        bannerView.rootViewController = self
        bannerView.loadRequest(request)
        
        
        // 이름 라벨에 유저 이름 표시 및 로그 아웃 버튼 활성화
        if let user = FIRAuth.auth()?.currentUser{
            self.logoutButton.alpha = 1.0
            self.loginButton.alpha = 0.0
            self.usernameLabel.text = user.email
        }
            
        else {
            self.logoutButton.alpha = 0.0
            self.loginButton.alpha = 1.0
            self.usernameLabel.text = ""
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func creatAccountAction(sender: AnyObject) {
        // emailfield 와 password 필드중 하나가 공백일때
        if self.emailField.text == "" || self.passwordField.text == ""{
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        else{
            FIRAuth.auth()?.createUserWithEmail(self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                if error == nil{
                    self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.emailField.text = ""
                    self.emailField.text = ""
                }
                else{
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func loginAction(sender: AnyObject) {
        if self.emailField.text == "" || self.passwordField.text == ""{
            
            let alertController = UIAlertController(title: "Oops!", message: "Please enter an email and password", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
            
        else{
            
            FIRAuth.auth()?.signInWithEmail(self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                
                if error == nil{
                    self.logoutButton.alpha = 1.0
                    self.usernameLabel.text = user!.email
                    self.emailField.text = ""
                    self.emailField.text = ""
                }
                    
                else{
                    let alertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .Alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func logoutAction(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        
        self.usernameLabel.text = ""
        self.logoutButton.alpha = 0.0
        self.emailField.text = ""
        self.passwordField.text = ""
    }

}

