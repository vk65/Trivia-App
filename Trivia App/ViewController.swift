//
//  ViewController.swift
//  Trivia App
//
//  Created by Cheripelly tirumala on 16/04/21.
//

import UIKit

class ViewController: UIViewController {

    
    //creating a variable for imageView
    @IBOutlet weak var imgView: UIImageView!
    
    //creating a variable for label
    @IBOutlet weak var Label: UILabel!
    
    //creating a variable for textfield
    @IBOutlet weak var nameField: UITextField!
    
    //creating a variable for button
    @IBOutlet weak var StartButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello")
        //calling the delegate method
       // nameField.delegate = self
        // Do any additional setup after loading the view.
    }


    
    //creating a function
    @IBAction func StartAction(_ sender: UIButton) {
        
        //accessing a control statements for accesing the start buuton
        if (nameField.text!.count > 7)
        {
            
            StartButton.isEnabled == true
            //creating a instance for view controller for passing the data
            var nextScreen = storyboard?.instantiateViewController(identifier: "nextScreen") as! NextViewController
//             nameField.text = nextScreen.lblName.text
            navigationController?.pushViewController(nextScreen, animated: true)
        
        }
        else
        {
            StartButton.isEnabled == false
        }
    }
    
    
}

