//
//  NewRecipeTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/29/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

var globalName = ""
var globalTime = ""
var globalPortions = ""

class NewRecipeTableViewController: UITableViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtPortions: UITextField!
    
    
    @IBAction func onCreateRecipe(sender: UIButton) {
        
        let checkName = txtName.text!.isEmpty
        let checkTime = txtTime.text!.isEmpty
        let checkPortions = txtPortions.text!.isEmpty
        let checkIngredients = globalIngredients.isEmpty
        let checkInstructions = globalIngredients.isEmpty
        
        if(checkName || checkTime || checkPortions){
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
        
        if (checkIngredients || checkInstructions){
            let title = "Warning"
            let message = "You need to add both ingredients and instructions."
            
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
        
        let recipeObject = PFObject(className: "Recipe")
        recipeObject["name"] = txtName.text
        
        let image = UIImage(named: "chocolate_cookies")
        let data = UIImagePNGRepresentation(image!)
        let file = PFFile(name: "image", data: data!)
        recipeObject["img"] = file
        
        recipeObject["time"] = txtTime.text
        recipeObject["portions"] = txtPortions.text
        recipeObject["ingredients"] = globalIngredients
        recipeObject["instructions"] = globalInstructions
        
        recipeObject["userId"] = userId
        
        recipeObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            let title:String
            let message:String
            
            if(success){
                title = "Success"
                message = "Your Recipe has been created!"
                
                globalName = ""
                globalTime = ""
                globalPortions = ""
                globalIngredients = [String]()
                globalInstructions = [String]()
                
            }else{
                title = "Error"
                message = "Your Recipe has not been created!"
            }
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { _ in
//                self.performSegueWithIdentifier("fromNewRecipeToMyRecipes", sender: self)
                
                self.navigationController!.popViewControllerAnimated(true)

            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,   sender: AnyObject?) {
        /*if let target = segue.destinationViewController as?  AddIngredientsTableViewController {
            target.ingredients = ingredients
        }*/
        
        globalName = txtName.text!
        globalTime = txtTime.text!
        globalPortions = txtPortions.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtName.text = globalName
        txtTime.text = globalTime
        txtPortions.text = globalPortions
        
        tableView.allowsSelection = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
        
    }
}
