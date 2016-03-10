//
//  LoginViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

var globalUserName:String?

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    

    @IBAction func onLogin(sender: UIButton) {
        
        if(txtEmail.text!.isEmpty || txtPassword.text!.isEmpty){
            let title = "Warning"
            let message = "All fileds are required."
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay",
                style: .Default, handler: nil)
            alertController.addAction(okayAction)
            presentViewController(alertController,
                animated: true, completion: nil)
            
            return
        }
        
        PFUser.logInWithUsernameInBackground(txtEmail.text!, password:txtPassword.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                globalUserName = user?.username
                self.performSegueWithIdentifier("fromLoginToHome", sender: self)
            } else {
                
                let title = "Error"
                let message = error!.userInfo["error"] as? String
                let alertController = UIAlertController(
                    title: title, message: message,
                    preferredStyle: .Alert)
                let okayAction = UIAlertAction(title: "Okay",
                    style: .Default, handler: nil)
                alertController.addAction(okayAction)
                self.presentViewController(alertController,
                    animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func dismissTextField(sender: UITextField) {
        sender.resignFirstResponder()

    }
    
    @IBAction func onDismissPassword(sender: UITextField) {
        sender.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
