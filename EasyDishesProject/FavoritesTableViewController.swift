//
//  FavoritesTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/27/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse


class FavoritesTableViewController: UITableViewController {
    
    var favoriteRecipes : [PFObject] = [];
    var favoriteRecipesIds : [String] = [];
    
    func getFavoriteRecipes(){
        let currentUser = PFUser.currentUser();
        favoriteRecipesIds = currentUser!["favorites"] as! [String]
        let query = PFQuery(className:"Recipe")
        query.whereKey("objectId",containedIn: favoriteRecipesIds)
        query.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error:NSError?) -> Void in
            if error == nil{
                self.favoriteRecipes = objects!;
                print(objects!.count)
                self.tableView.reloadData()
                print(userId!)
            }
        }

        
    }

    
    override func viewWillAppear(animated: Bool) {
        getFavoriteRecipes();
    }

    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor()
        
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        //tableView.delegate = self;
        //tableView.dataSource = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell;
        if(indexPath.row%2==0){
            cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as UITableViewCell
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("basic2", forIndexPath: indexPath) as UITableViewCell
        }
        
        cell.textLabel?.text = favoriteRecipes[indexPath.row]["name"] as? String;
        
        if let image = favoriteRecipes[indexPath.row]["img"] as? PFFile{
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
        if(favoriteRecipes.count != 0){
            globalRecipeId = favoriteRecipes[indexPath.row].objectId!
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
