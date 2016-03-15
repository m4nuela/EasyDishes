//
//  MyRecipesTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/27/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

class MyRecipesTableViewController: UITableViewController {

    var myRecipesList : [PFObject] = [];
    
    func getMyRecipes(){
        let query = PFQuery(className:"Recipe")
        query.whereKey("userId",equalTo:globalUserName!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error:NSError?) -> Void in
            if error == nil{
                self.myRecipesList = objects!;
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        getMyRecipes();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.view.addGestureRecognizer(longPressRecognizer)
        
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
        return myRecipesList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell;
        if(indexPath.row%2==0){
            cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as UITableViewCell
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("basic2", forIndexPath: indexPath) as UITableViewCell
        }
        
        cell.textLabel?.text = myRecipesList[indexPath.row]["name"] as? String
        
        if let image = myRecipesList[indexPath.row]["img"] as? PFFile{
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
        if(myRecipesList.count != 0){
            globalRecipeId = myRecipesList[indexPath.row].objectId!
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.view)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                
                let alertController = UIAlertController(title: "Delete", message: "Do you really want to delete this recipe?", preferredStyle: .Alert);
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler:nil);
                let forceAction = UIAlertAction(title: "Yes", style: .Destructive){ _ in
                    
                    self.myRecipesList[indexPath.row].deleteInBackground()
                    self.getMyRecipes()
                    self.tableView.reloadData()

                }
                    
                    alertController.addAction(cancelAction);
                    alertController.addAction(forceAction);
                    
                    presentViewController(alertController, animated: true,completion: nil);
            }
        }
    }
}
