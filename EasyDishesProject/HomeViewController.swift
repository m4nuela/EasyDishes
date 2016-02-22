//
//  HomeViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteRecipes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell :UITableViewCell;
        if(indexPath.row%2==0){
            cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as UITableViewCell
        }else{
            cell = tableView.dequeueReusableCellWithIdentifier("basic2", forIndexPath: indexPath) as UITableViewCell
        }
        
        
        
        
        cell.textLabel?.text = favoriteRecipes[indexPath.row]
        
        return cell
    }

    
}
