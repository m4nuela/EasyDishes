//
//  homeTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//


import UIKit

let recipes = ["Coxinha","Pastel","Bobo de camarao", "Bolo de rolo", "Canjica", "Petit Gateu","Cheese cake","brownie","Cookies","brigadeiro"];


class HomeTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basic",forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = recipes[indexPath.row];
        return cell;
    }


}
