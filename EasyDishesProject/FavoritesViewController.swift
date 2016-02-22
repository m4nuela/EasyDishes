//
//  FavoritesViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

let favoriteRecipes = ["Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim","Coxinha","Brigadeiro","Pastel","Cachorro Quente", "Bolo de rolo","Pudim"];

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //tableView.delegate = self;
        //tableView.dataSource = self;
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
    
//    override func tableView(tableView: UITableView,
//        didSelectRowAtIndexPath indexPath: NSIndexPath) {
//            let title = "Wine List"
//            let message = "You have selected \(wines[indexPath.row])"
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//            let okayAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
//            alertController.addAction(okayAction)
//            presentViewController(alertController, animated: true, completion: nil)
//            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }


}
