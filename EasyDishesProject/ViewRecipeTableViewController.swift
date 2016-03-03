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
    var foodImage:UIImage?
    
    @IBAction func onFavRecipe(sender: UIButton) {
       
        let query = PFUser.query()
        query!.whereKey("username", equalTo: PFUser.currentUser()!.username!)
        query!.getFirstObjectInBackgroundWithBlock {
            (object: PFObject?, error: NSError?) -> Void in
            if (error != nil) {
                print(error)
            } else if let user = object {
                var oldFavorites:[String] = user["favorites"] as! [String]
                oldFavorites.append(self.recipeId)
                user["favorites"] = oldFavorites
                user.saveInBackground()
                
                let title = "Sucess"
                let message = "The recipe has been favorited!"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
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
                if let image = recipe["img"] as? PFFile{
                    image.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                        if (error == nil) {
                            self.foodImage = UIImage(data:imageData!)
                            self.tableView.reloadData()
                        }
                    }
                }
                do{
                    try self.userAuthor = PFQuery.getUserObjectWithId(self.authorId)
                }catch _ {}
            }
        }
        
        let nib = UINib(nibName: "recipeImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "imageCell")
        
        let nib2 = UINib(nibName: "cookAndServeCell", bundle: nil)
        tableView.registerNib(nib2, forCellReuseIdentifier: "cookAndServeCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 + ingredientsList.count + instructionsList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        if(recipe == nil){
            return cell
        }
    
        switch(indexPath.row){
        case 0:
            
            let cellImg:RecipeImageTableViewCell
            cellImg = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! RecipeImageTableViewCell
            cellImg.img.image = foodImage
            return cellImg
        
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
            cell.textLabel?.text = recipe!["name"] as? String
            return cell

        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
            cell.textLabel?.text = userAuthor?.username
            return cell

        case 3:
            let cellCookServe:cookAndServeTableViewCell
            cellCookServe = tableView.dequeueReusableCellWithIdentifier("cookAndServeCell", forIndexPath: indexPath) as! cookAndServeTableViewCell
            cellCookServe.lblTime.text = recipe!["time"] as? String
            cellCookServe.lblPortions.text = recipe!["portions"] as? String

            return cellCookServe
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("ingredCell", forIndexPath: indexPath)
            cell.textLabel?.text = "INGREDIENTS"
            return cell
 
        default:
            if(indexPath.row >= 5 && indexPath.row < 5 + ingredientsList.count){
                cell = tableView.dequeueReusableCellWithIdentifier("ingredientCell", forIndexPath: indexPath)
                cell.textLabel?.text = ingredientsList[indexPath.row-5]
                
            }else if (indexPath.row == 5 + ingredientsList.count){
                cell = tableView.dequeueReusableCellWithIdentifier("instructCell", forIndexPath: indexPath)
                cell.textLabel?.text = "INSTRUCTIONS"
            
            }else{
                let index = indexPath.row-(6 + ingredientsList.count)
                cell = tableView.dequeueReusableCellWithIdentifier("instructionCell", forIndexPath: indexPath)
                cell.textLabel?.text = instructionsList[index]
            }
            return cell
        }
        
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
   
}
