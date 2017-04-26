//
//  AddClassVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit

protocol CourseAddedDelegate {
    func saveAddedClass(data: Course)
}

class AddClassVC: UIViewController {

    var delegate: CourseAddedDelegate? = nil
    
    @IBOutlet weak var courseField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        courseField.setBottomBorder()
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveAction(_ sender: Any) {
        
        let courseName = courseField.text ?? "N/A"
        
        let _ = DatabaseController.newCourse(courseName: courseName)

        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
