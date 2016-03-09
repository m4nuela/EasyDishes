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
        query.whereKey("userId",equalTo:userId!)
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error:NSError?) -> Void in
            if error == nil{
                self.myRecipesList = objects!;
                self.tableView.reloadData()
                //print(userId!)
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
        
//        let nib = UINib(nibName: "myCell", bundle: nil);
//        tableView.registerNib(nib, forCellReuseIdentifier: "MyRecipes");
//        
//        
//        let nib2 = UINib(nibName: "myCell2", bundle: nil);
//        tableView.registerNib(nib2, forCellReuseIdentifier: "MyRecipes2");
        
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
        
        
//        if(indexPath.row%2==0){
//            let cell1 :myCellTableViewCell;
//            cell1 = tableView.dequeueReusableCellWithIdentifier("MyRecipes", forIndexPath: indexPath) as! myCellTableViewCell
//            cell1.label?.text = favoriteRecipes[indexPath.row];
//            cell1.img.image = UIImage(named:"image.png");
//            
//            return cell1;
//            
//            //cell.imgCarName.image = UIImage(named: tableData[indexPath.row])
//            
//            
//        }else{
//            let cell2 :myCell2TableViewCell
//            cell2 = tableView.dequeueReusableCellWithIdentifier("MyRecipes2", forIndexPath: indexPath) as! myCell2TableViewCell
//            cell2.label?.text = favoriteRecipes[indexPath.row];
//            cell2.img.image = UIImage(named:"image");
//            return cell2;
//        }
        
        
        
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
        //print("Row \(indexPath.row) selected")
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
                    
                    //remover do parse
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
