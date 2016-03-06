//
//  NewRecipeTableViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 2/29/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit
import Parse

var globalName = ""
var globalTime = ""
var globalPortions = ""
var globalImagePhoto = UIImage(named: "chocolate_cookies");

class NewRecipeTableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBAction func pinchedDetected(sender: UIPinchGestureRecognizer) {
        print("pinched!!!!")
        imgPhoto.transform = CGAffineTransformScale(imgPhoto.transform, sender.scale, sender.scale)
        
    }

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var txtPortions: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func onCreateRecipe(sender: UIButton) {
        
        let checkName = txtName.text!.isEmpty
        let checkTime = txtTime.text!.isEmpty
        let checkPortions = txtPortions.text!.isEmpty
        let checkIngredients = globalIngredients.isEmpty
        let checkInstructions = globalIngredients.isEmpty
        
        if(checkName || checkTime || checkPortions){
            let title = "Warning"
            let message = "All fileds are required."
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay",
                style: .Default, handler: nil)
            alertController.addAction(okayAction)
            presentViewController(alertController,
                animated: true, completion: nil)
            
            return
        }
        
        if (checkIngredients || checkInstructions){
            let title = "Warning"
            let message = "You need to add both ingredients and instructions."
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay",
                style: .Default, handler: nil)
            alertController.addAction(okayAction)
            presentViewController(alertController,
                animated: true, completion: nil)
            
            return
        }
        
        let recipeObject = PFObject(className: "Recipe")
        recipeObject["name"] = txtName.text
        
        let image = imgPhoto.image
        let data = UIImagePNGRepresentation(image!)
        let file = PFFile(name: txtName.text, data: data!)
        recipeObject["img"] = file
        
        recipeObject["time"] = txtTime.text
        recipeObject["portions"] = txtPortions.text
        recipeObject["ingredients"] = globalIngredients
        recipeObject["instructions"] = globalInstructions
        
        recipeObject["userId"] = userId
        
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
        
        recipeObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            let title:String
            let message:String
            
            if(success){
                title = "Success"
                message = "Your Recipe has been created!"
                /*
                globalName = ""
                globalTime = ""
                globalPortions = ""
                globalIngredients = [String]()
                globalInstructions = [String]()
                */
            }else{
                title = "Error"
                message = "Your Recipe has not been created!"
            }
            
            let alertController = UIAlertController(
                title: title, message: message,
                preferredStyle: .Alert)
            let okayAction = UIAlertAction(title: "Okay", style: .Default) { _ in
                //self.performSegueWithIdentifier("fromNewRecipeToMyRecipes", sender: self)
                self.navigationController!.popViewControllerAnimated(true)
            }
            alertController.addAction(okayAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        activityIndicator.stopAnimating()
        activityIndicator.hidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,   sender: AnyObject?) {
        globalName = txtName.text!
        globalTime = txtTime.text!
        globalPortions = txtPortions.text!
        globalImagePhoto = imgPhoto.image!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidden = true
        
        txtName.text = globalName
        txtTime.text = globalTime
        txtPortions.text = globalPortions
        imgPhoto.image = globalImagePhoto
        
        tableView.allowsSelection = false;
        
        let imageView = imgPhoto
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
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
        return 6
        
    }
    
    func imageTapped(img: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        imgPhoto.image = scaleImage(image, toSize: CGSize(width:800, height: 800))
        imgPhoto.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    func scaleImage(image: UIImage, toSize newSize: CGSize) -> (UIImage) {
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context, .High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        CGContextConcatCTM(context, flipVertical)
        CGContextDrawImage(context, newRect, image.CGImage)
        let newImage = UIImage(CGImage: CGBitmapContextCreateImage(context)!)
        UIGraphicsEndImageContext()
        return newImage
    }
}
