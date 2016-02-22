//
//  MyRecipesViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 2/21/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class MyRecipesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    

    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        let nib = UINib(nibName: "myCell", bundle: nil);
        tableView.registerNib(nib, forCellReuseIdentifier: "myRecipes");
        
        
        let nib2 = UINib(nibName: "myCell2", bundle: nil);
        tableView.registerNib(nib2, forCellReuseIdentifier: "myRecipes2");
        
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
        var cell1 :myCellTableViewCell
        var cell2 :myCell2TableViewCell
        if(indexPath.row%2==0){
            cell1 = tableView.dequeueReusableCellWithIdentifier("MyRecipes", forIndexPath: indexPath) as! myCellTableViewCell
            cell1.textLabel?.text = favoriteRecipes[indexPath.row];
            return cell1;
        }else{
            cell2 = tableView.dequeueReusableCellWithIdentifier("MyRecipes2", forIndexPath: indexPath) as! myCell2TableViewCell
            
            cell2.textLabel?.text = favoriteRecipes[indexPath.row];
            return cell2;
        }
        
        
    
    }


}
