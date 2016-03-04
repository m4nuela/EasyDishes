//
//  SearchTableViewController.swift
//  EasyDishesProject
//
//  Created by Manuela Barbosa on 3/2/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse



class SearchTableViewController: UITableViewController {
    
    var retrievedRecipes : [PFObject] = [];

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func search(sender: UIBarButtonItem) {
        
        retrievedRecipes = [];
        
        var words :[String];
        if let phrase = textField.text{
            words = removeStopwords(phrase)
            
            
            // check if the person typed the title of the recipe
            let query = PFQuery(className:"Recipe")
            query.whereKey("name", equalTo : phrase)
            query.findObjectsInBackgroundWithBlock{
                (objects: [PFObject]?, error:NSError?) -> Void in
                if error == nil{
                    self.retrievedRecipes = Array(Set(self.retrievedRecipes + objects!));
                    
                    self.tableView.reloadData()
                }else{
                    print("0")
                    print(error?.description)
                }
            }
            
            // check if the person typed the title of the recipe2
            for word in words{
                let query = PFQuery(className:"Recipe")
                query.whereKey("name", containsString: word)
                //query.whereKey("ingredients",containedIn: query2)
                query.findObjectsInBackgroundWithBlock{
                    (objects: [PFObject]?, error:NSError?) -> Void in
                    if error == nil{
                        self.retrievedRecipes = Array(Set(self.retrievedRecipes + objects!));
                        self.tableView.reloadData()
                    }else{
                        print("1")
                        print(error?.description)
                    }
                }
            }
            
            
            
            //check if the person typed ingredients
            for word in words{
                let query = PFQuery(className:"Recipe")
                query.whereKey("ingredients", equalTo: word)
                //query.whereKey("ingredients",containedIn: query2)
                query.findObjectsInBackgroundWithBlock{
                    (objects: [PFObject]?, error:NSError?) -> Void in
                    if error == nil{
                        self.retrievedRecipes = Array(Set(self.retrievedRecipes + objects!));
                        self.tableView.reloadData()
                    }else{
                        print("2")
                        print(error?.description)
                        
                    }
                }
            }
            
            
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "search", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "searchCell")
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return retrievedRecipes.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        switch(indexPath.row){
        
        default:
            if(indexPath.row%2==0){
                cell = tableView.dequeueReusableCellWithIdentifier("basic", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = retrievedRecipes[indexPath.row]["name"] as? String
                return cell
            }else{
                cell = tableView.dequeueReusableCellWithIdentifier("basic2", forIndexPath: indexPath) as UITableViewCell
                cell.textLabel!.text = retrievedRecipes[indexPath.row]["name"] as? String
                return cell
            }
        }
        
        
        
        

        // Configure the cell...

        //return cell
    }
    
    
    
    let stopwords = ["a","about","above","after","before","the","I", "me","of","all","an", "and","any","are","is","as","at","be","by","do","does","have","into","in","on","at","isn't","aren't", "no","not","only","or","and","some","to","what","where","who","which","why","with", "under"];
    
    func removeStopwords(phrase :String) -> [String]{
        var retorno = [String]()
        let wordArray = phrase.componentsSeparatedByString(" ")
        for word in wordArray{
            if (stopwords.contains(word)){
            }else{
                retorno.append(word)
            }
        }
        
        return retorno
    }

    

}
