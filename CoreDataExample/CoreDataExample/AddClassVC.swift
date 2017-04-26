//
//  AddClassVC.swift
//  CoreDataExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import CoreData

class AddClassVC: UIViewController {

    @IBOutlet weak var classNameField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        classNameField.setBottomBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let classObj: Course = Course(context: DatabaseController.getContext())
        
        classObj.courseName = classNameField.text
        
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
