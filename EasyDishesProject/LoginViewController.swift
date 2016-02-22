//
//  LoginViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

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

        
        let query = PFQuery(className:"User")
        query.whereKey("email", equalTo:txtEmail.text!)
        query.whereKey("password", equalTo:txtPassword.text!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if(error == nil){
                if let result = objects {
                    if(!result.isEmpty){
                        self.performSegueWithIdentifier("fromLoginToHome", sender: self)
                    }else{
                        let title = "Error"
                        let message = "The Email or Password are wrong."
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
