//
//  StudentDetailVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import Firebase

class StudentDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseSelectedDelegate {

    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var ageField: UILabel!
    
    @IBOutlet weak var coursesTable: UITableView!
    
    var ref: FIRDatabaseReference!
    
    var student: Student! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference(withPath: "student-items")
        
        nameField.text = "\(student.firstName) \(student.lastName)"
        
        ageField.text = "\(student.age)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Actions

    @IBAction func deleteAction(_ sender: Any) {
        
        deleteChild(childIWantToRemove: student.getIdentifier())
        
        navigationController?.popViewController(animated: true)
    }


    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return student.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coursesTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = student.courses[indexPath.row]
        
        return cell
    }
 
    func deleteChild(childIWantToRemove: String) {
        
        ref.child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
        }
    }
    
    func didSelectCourse(data: String){
        
        student.courses.append(data)
        
        let studentRef = self.ref.child(student.getIdentifier())
        
        studentRef.setValue(student.toAnyObject())
        
        coursesTable.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ClassesTableVC
        
        dest.delegate = self
    }

}
