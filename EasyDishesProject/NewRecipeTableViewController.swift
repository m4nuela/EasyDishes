//
//  NewRecipeTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/29/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

var name = ""
var time = ""
var portions = ""

class NewRecipeTableViewController: UITableViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtPortions: UITextField!
    
    
    @IBAction func onCreateRecipe(sender: UIButton) {
        
        let recipeObject = PFObject(className: "Recipe")
        recipeObject["name"] = txtName.text
        
        let image = UIImage(named: "chocolate_cookies")
        let data = UIImagePNGRepresentation(image!)
        let file = PFFile(name: "image", data: data!)
        recipeObject["img"] = file
        
        recipeObject["time"] = txtTime.text
        recipeObject["portions"] = txtPortions.text
        recipeObject["ingredients"] = globalIngredients
        recipeObject["instructions"] = globalInstruction
        
        recipeObject["userId"] = userId
        
        recipeObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            let title:String
            let message:String
            
            if(success){
                title = "Success"
                message = "Your Recipe has been created!"
            }else{
                title = "Error"
                message = "Your Recipe has not been created!"
            }
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { _ in
                self.performSegueWithIdentifier("fromNewRecipeToMyRecipes", sender: self)
            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,   sender: AnyObject?) {
        /*if let target = segue.destinationViewController as?  AddIngredientsTableViewController {
            target.ingredients = ingredients
        }*/
        
        name = txtName.text!
        time = txtTime.text!
        portions = txtPortions.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.text = name
        txtTime.text = time
        txtPortions.text = portions

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
