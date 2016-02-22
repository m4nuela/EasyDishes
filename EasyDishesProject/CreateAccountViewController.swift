//
//  CreateAccountViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordAgain: UITextField!
    
    @IBAction func onCreateAccount(sender: UIButton) {
        
        let checkEmail = txtEmail.text!.isEmpty
        let checkUsername = txtUsername.text!.isEmpty
        let checkPassword = txtPassword.text!.isEmpty
        let checkPasswordAgain = txtPasswordAgain.text!.isEmpty
        
        var title = ""
        var message = ""
        
        if(checkEmail || checkUsername || checkPassword || checkPasswordAgain){
            title = "Warning"
            message = "All fileds are required."
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
        
        if(txtPassword.text != txtPasswordAgain.text){
            title = "Warning"
            message = "The two Passwords must to be the same."
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
    
        let userObject = PFObject(className: "User")
        userObject["email"] = txtEmail.text
        userObject["username"] = txtUsername.text
        userObject["password"] = txtPassword.text
        userObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if(success){
                title = "Success"
                message = "Your Account has been created!"
            }else{
                title = "Error"
                message = "Your Account has not been created!"
            }
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { _ in
                self.dismissViewControllerAnimated(true, completion: nil)

            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    @IBAction func onDismissTextField(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onDismissUsername(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onDismissPassword(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onDismissPasswordAgain(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.placeholder = "Email"
        txtUsername.placeholder = "Username"
        txtPassword.placeholder = "Password"
        txtPasswordAgain.placeholder = "Password Again"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
