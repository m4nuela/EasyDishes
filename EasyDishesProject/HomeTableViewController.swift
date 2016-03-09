//
//  HomeTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/27/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

var globalRecipeId = ""

class HomeTableViewController: UITableViewController {
    
    var recipesList : [PFObject] = [];
    
    func getRecipes(){
        let query = PFQuery(className:"Recipe")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error:NSError?) -> Void in
            if error == nil{
                self.recipesList = objects!;
                self.tableView.reloadData()
                //print(userId!)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        getRecipes();
    }

    override func viewDidLoad() {
        super.viewDidLoad();
    
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }
    
override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell;
        if(indexPath.row%2==0){
            cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as UITableViewCell
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("basic2", forIndexPath: indexPath) as UITableViewCell
        }
    
    
//    let image = UIImage(named: "chocolate_cookies")
//    let data = UIImagePNGRepresentation(image!)
//    let file = PFFile(name: "image", data: data!)
//    recipeObject["img"] = file
    
    
        cell.textLabel?.text = recipesList[indexPath.row]["name"] as? String
        if let image = recipesList[indexPath.row]["img"] as? PFFile{
            image.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    cell.imageView?.image = UIImage(data:imageData!)
                }else{
                    cell.imageView?.image = UIImage(named: "image");
                }
                tableView.reloadData();
            }
        }
    
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        if(recipesList.count != 0){
            globalRecipeId = recipesList[indexPath.row].objectId!
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
