//
//  AddClassVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import Firebase

protocol CourseAddedDelegate {
    func saveAddedClass(data: Course)
}

class AddClassVC: UIViewController {

    var delegate: CourseAddedDelegate? = nil
    
    var coursesRef: FIRDatabaseReference!
    
    @IBOutlet weak var courseField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        courseField.setBottomBorder()
        
        coursesRef = FIRDatabase.database().reference(withPath: "courses-items")
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveAction(_ sender: Any) {
        
        let courseName = courseField.text ?? "N/A"
        
        let course = Course(name: courseName)
        
        let ref = self.coursesRef.child(courseName)
        
        ref.setValue(course.toAnyObject())
        
        delegate?.saveAddedClass(data: course)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

}
