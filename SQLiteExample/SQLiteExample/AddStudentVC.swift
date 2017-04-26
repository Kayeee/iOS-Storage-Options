//
//  AddStudentVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit

class AddStudentVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    
    
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
        
        let firstName = firstNameField.text ?? "N/A"
        let lastName = lastNameField.text ?? "N/A"
        let age = Int(ageField.text ?? "-1")

        DatabaseController.newStudent(firstName: firstName, lastName: lastName, age: age!)
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
