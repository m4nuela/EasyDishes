//
//  AddInstructionsTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/29/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

var globalInstructions = [String]()

class AddInstructionsTableViewController: UITableViewController {

    @IBOutlet weak var txtNewInstruction: UITextField!
    
    @IBOutlet weak var txtInstructionList: UITextView!
    
    
    @IBAction func onAddNewInstruction(sender: UIButton) {
        if (txtNewInstruction.text! != ""){
            globalInstructions.append(txtNewInstruction.text!)
        
            txtInstructionList.text = txtInstructionList.text + "\(globalInstructions.count)" + ". " + txtNewInstruction.text! + "\n"
            txtNewInstruction.text = ""
        }
    }
    
    @IBAction func onClearInstructionsList(sender: UIButton) {
        txtInstructionList.text = ""
        globalInstructions = [String]()
    }
    
    @IBAction func onSaveInstructionsList(sender: UIButton) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func onEditingChanged(sender: UITextField) {
        if (txtNewInstruction.text!.characters.count > 85) {
            txtNewInstruction.deleteBackward()
        }
    }
    
    @IBAction func onDidEndOnExit(sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(globalInstructions.count != 0){
            for i in 0...globalInstructions.count-1{
                txtInstructionList.text = txtInstructionList.text + "\(i+1)" + ". " + globalInstructions[i] + "\n"
            }
        }
        
        tableView.allowsSelection = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
}
