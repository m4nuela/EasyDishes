//
//  MyRecipesTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/27/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class MyRecipesTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        navigationController!.navigationBar.barTintColor = UIColor.orangeColor().colorWithAlphaComponent(0.25)
        
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        let nib = UINib(nibName: "myCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: "MyRecipes");
        
        
        let nib2 = UINib(nibName: "myCell2", bundle: nil);
        tableView.registerNib(nib2, forCellReuseIdentifier: "MyRecipes2");
        
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
        
        
        if(indexPath.row%2==0){
            let cell1 :myCellTableViewCell;
            cell1 = tableView.dequeueReusableCellWithIdentifier("MyRecipes", forIndexPath: indexPath) as! myCellTableViewCell
            cell1.label?.text = favoriteRecipes[indexPath.row];
            cell1.img.image = UIImage(named:"image.png");
            
            return cell1;
            
            //cell.imgCarName.image = UIImage(named: tableData[indexPath.row])
            
            
        }else{
            let cell2 :myCell2TableViewCell
            cell2 = tableView.dequeueReusableCellWithIdentifier("MyRecipes2", forIndexPath: indexPath) as! myCell2TableViewCell
            cell2.label?.text = favoriteRecipes[indexPath.row];
            cell2.img.image = UIImage(named:"image");
            return cell2;
        }
        //return cell;
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
