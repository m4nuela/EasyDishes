//
//  ViewRecipeTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/28/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class ViewRecipeTableViewController: UITableViewController {

    var ingredIndex = 0
    var instrIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "recipeImageCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "imageCell")
        
        let nib2 = UINib(nibName: "cookAndServeCell", bundle: nil)
        tableView.registerNib(nib2, forCellReuseIdentifier: "cookAndServeCell")
        
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
        return 6 + 2*favoriteRecipes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
    
        switch(indexPath.row){
        case 0:
            let cellImg:RecipeImageTableViewCell
            cellImg = tableView.dequeueReusableCellWithIdentifier("imageCell", forIndexPath: indexPath) as! RecipeImageTableViewCell
            
            cellImg.img.image = UIImage(named: "food3")
            
            return cellImg
        
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath)
            cell.textLabel?.text = "Title"
            return cell

        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("authorCell", forIndexPath: indexPath)
            cell.textLabel?.text = "by author"
            return cell

        case 3:
            let cellCookServe:cookAndServeTableViewCell
            cellCookServe = tableView.dequeueReusableCellWithIdentifier("cookAndServeCell", forIndexPath: indexPath) as! cookAndServeTableViewCell
            cellCookServe.lblTime.text = "time"
            cellCookServe.lblPortions.text = "5"

            return cellCookServe
            
        case 4:
            cell = tableView.dequeueReusableCellWithIdentifier("ingredCell", forIndexPath: indexPath)
            cell.textLabel?.text = "INGREDIENTS"
            return cell
 
        default:
            if(indexPath.row >= 5 && indexPath.row < 5 + favoriteRecipes.count){
                cell = tableView.dequeueReusableCellWithIdentifier("ingredientCell", forIndexPath: indexPath)
                cell.textLabel?.text = favoriteRecipes[indexPath.row-5]
                
            }else if (indexPath.row == 5 + favoriteRecipes.count){
                cell = tableView.dequeueReusableCellWithIdentifier("instructionCell", forIndexPath: indexPath)
                cell.textLabel?.text = "INSTRUCTIONS"
            
            }else{
                cell = tableView.dequeueReusableCellWithIdentifier("instructionCell", forIndexPath: indexPath)
                cell.textLabel?.text = favoriteRecipes[indexPath.row-(6 + favoriteRecipes.count)]
                    
            }
            return cell
        }
        // Configure the cell...
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 280
        }else{
            return 50
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
