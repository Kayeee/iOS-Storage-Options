//
//  AddStudentVC.swift
//  CoreDataExample
//
//  Created by Kevin on 2/6/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit

class AddStudentVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.setBottomBorder()
        lastNameField.setBottomBorder()
        ageField.setBottomBorder()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func saveAction(_ sender: Any) {
        
        let student: Student = Student(context: DatabaseController.getContext())
        student.firstName = firstNameField.text ?? "N/A"
        student.lastName = lastNameField.text ?? "N/A"
        student.age = Int16(ageField.text!) ?? 1
        
        DatabaseController.saveContext()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    

}
