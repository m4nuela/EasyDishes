//
//  AddIngredientsTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/29/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

var globalIngredients = [String]()
var globalIngredientsString :String = ""

class AddIngredientsTableViewController: UITableViewController {

    @IBOutlet weak var txtNewIngredient: UITextField!
    @IBOutlet weak var txtIngredientsList: UITextView!

    
    @IBAction func onClearList(sender: UIButton) {
        txtIngredientsList.text = ""
        globalIngredientsString = ""
        globalIngredients = [String]()
    }
    
    @IBAction func onAddIngredient(sender: UIButton) {
        if (txtNewIngredient.text! != ""){
            globalIngredients.append(txtNewIngredient.text!)
            txtIngredientsList.text = txtIngredientsList.text + ". " + globalIngredients.last! + "\n"
            globalIngredientsString = globalIngredientsString + globalIngredients.last! + " "
            txtNewIngredient.text = ""
        }
    }
    
    @IBAction func onSaveIngredientsList(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    @IBAction func onDidEndOnExitNewIngredient(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(globalIngredients.count != 0){
            for i in 0...globalIngredients.count-1{
                txtIngredientsList.text = txtIngredientsList.text + ". " + globalIngredients[i] + "\n"
            }
        }
        
        tableView.allowsSelection = false;

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
        return 3
    }
}
