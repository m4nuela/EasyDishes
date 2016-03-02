//
//  ViewRecipeTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/28/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

/*
var cookiesIngredients = [". 1 cup of softened butter", ". 1 cup of brown sugar", ". 1/3 of castor sugar", ". 2 eggs", ". 2 tsp of vanilla extract", ". 1 cup of flour", ". 1 tsp of baking powder", ". 1 tsp of baking soda", ". 1 cup of chocolate chips"]

var cookiesInstructions = ["1 - Beat butter and sugar till light and fluffy. Add in the eggs one at a time. Add vanilla.", "2 - Whisk together flour, baking powder and baking soda. Fold this mixture into the wet mixture. The dough will be very stiff. Add in the chocolate chips and fold.", "3 - Take a scoop of batter and roll into a ball. Flatten a little and place on baking sheet lined with parchment paper. Place the balls at a distance from each other. Bake and flatten the cookies a little if they inflate while baking.", "4 - Let them cool and enjoy."]

*/
class ViewRecipeTableViewController: UITableViewController {
    
    var recipeId = "9kfA00UXiX"
    var recipe:PFObject?
    var userAuthor:PFUser?
    var authorId:String = ""
    var ingredientsList = [String]()
    var instructionsList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let query = PFQuery(className:"Recipe")
        query.whereKey("objectId", equalTo:recipeId)
        query.findObjectsInBackgroundWithBlock {
            (recipes: [PFObject]?, error: NSError?) -> Void in
            if (error != nil && recipes == nil) {
                print(error)
            } else if let recipe = recipes!.first {
                self.recipe = recipe
                self.authorId = recipe["userId"] as! String
                self.ingredientsList = recipe["ingredients"] as! [String]
                
                self.instructionsList = recipe["instructions"] as! [String]
            }
        }
        */

        let query = PFQuery(className:"Recipe")
        query.getObjectInBackgroundWithId(recipeId) {
            (recipe: PFObject?, error: NSError?) -> Void in
            if (error != nil && recipe == nil) {
                print(error)
            } else if let recipe = recipe {
                self.recipe = recipe
                self.authorId = recipe["userId"] as! String
                self.ingredientsList = recipe["ingredients"] as! [String]
                
                self.instructionsList = recipe["instructions"] as! [String]
            }
        }
        
        do{
            try userAuthor = PFQuery.getUserObjectWithId(authorId)
        }catch _ {}
        
        /*
        let nib = UINib(nibName: "recipeImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "imageCell")
        
        let nib2 = UINib(nibName: "cookAndServeCell", bundle: nil)
        tableView.registerNib(nib2, forCellReuseIdentifier: "cookAndServeCell")
       
        */
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
        return 6 + ingredientsList.count + ingredientsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
    
        switch(indexPath.row){
        case 0:
            /*
            let cellImg:RecipeImageTableViewCell
            cellImg = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! RecipeImageTableViewCell
            
            cellImg.img.image = UIImage(named: "chocolate_cookies")
            */
            cell = tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
            return cell //cellImg
        
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
            cell.textLabel?.text = recipe!["name"] as? String //"Chocolate chip cookies"
            return cell

        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
            cell.textLabel?.text = userAuthor!["username"] as? String //"by Manuela"
            return cell

        case 3:
            let cellCookServe:cookAndServeTableViewCell
            cellCookServe = tableView.dequeueReusableCellWithIdentifier("cookAndServeCell", forIndexPath: indexPath) as! cookAndServeTableViewCell
            cellCookServe.lblTime.text = recipe!["time"] as? String //"1h 30min"
            cellCookServe.lblPortions.text = recipe!["portions"] as? String //"5"

            return cellCookServe
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("ingredCell", forIndexPath: indexPath)
            cell.textLabel?.text = "INGREDIENTS"
            return cell
 
        default:
            if(indexPath.row >= 5 && indexPath.row < 5 + ingredientsList.count){
                cell = tableView.dequeueReusableCellWithIdentifier("ingredientCell", forIndexPath: indexPath)
                cell.textLabel?.text = ingredientsList[indexPath.row-5]
                // var ingredients = recipe["ingredients"] as NSArray; cell.textLabel?.text = ingredients[indexPath.row-5]
                
            }else if (indexPath.row == 5 + ingredientsList.count){
                cell = tableView.dequeueReusableCellWithIdentifier("instructionCell", forIndexPath: indexPath)
                cell.textLabel?.text = "INSTRUCTIONS"
            
            }else{
                cell = tableView.dequeueReusableCellWithIdentifier("instructionCell", forIndexPath: indexPath)
                cell.textLabel?.text = instructionsList[indexPath.row-(6 + ingredientsList.count)]
                
                // var instructions = recipe["instructions"] as NSArray; cell.textLabel?.text = instructions[indexPath.row-5]
                    
            }
            return cell
        }
        // Configure the cell...
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 250
        }else if (indexPath.row == 3 || indexPath.row > 5 + ingredientsList.count){
            return 50
        }else{
            return 40
        }
    }
   
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
