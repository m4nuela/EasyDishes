//
//  ImagePreviewViewController.swift
//  EasyDishesProject
//
//  Created by Nicolas Oliveira Gomes do Nascimento on 3/5/16.
//  Copyright © 2016 Manuela Barbosa. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var imgPhoto: UIImageView!
    
    @IBAction func pinchRecognizer(sender: UIPinchGestureRecognizer) {
        print("pinched!!!!")
        
        if let view = sender.view {
            view.transform = CGAffineTransformScale(view.transform,
                sender.scale, sender.scale)
            if CGFloat(view.transform.a) > 5 {
                view.transform.a = 5 // this is x coordinate
                view.transform.d = 5 // this is x coordinate
            }
            if CGFloat(view.transform.d) < 1 {
                view.transform.a = 1 // this is x coordinate
                view.transform.d = 1 // this is x coordinate
            }
            sender.scale = 1
        }
        imgPhoto.transform = CGAffineTransformScale(imgPhoto.transform, sender.scale, sender.scale)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPhoto.image = globalImagePreview
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
