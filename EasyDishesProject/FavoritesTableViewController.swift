//
//  FavoritesTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/27/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

let favoriteRecipes = ["Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim"];

class FavoritesTableViewController: UITableViewController {

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
        
        cell.textLabel?.text = favoriteRecipes[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}
