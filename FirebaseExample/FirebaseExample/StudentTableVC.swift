//
//  StudentTableVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import Firebase

class StudentTableVC: UITableViewController {

    var students: [Student] = []
    
    var ref: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference(withPath: "student-items")
        
        ref.queryOrderedByKey().observe(.value, with: { snapshot in
            
            var newItems: [Student] = []
            
            for item in snapshot.children {
                
                newItems.append(Student(snapshot: item as! FIRDataSnapshot))
            }
            
            self.students = newItems
            self.tableView.reloadData()
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Table view
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return students.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let student = students[indexPath.row]
        
        cell.textLabel?.text = "\(student.firstName) \(student.lastName)"
        
        cell.detailTextLabel?.text = "\(student.age)"

        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addStudent" {
            
            _ = segue.destination as! AddStudentVC
        } else {
            
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)

            let dest = segue.destination as! StudentDetailVC
            
            dest.student = students[(path?.row)!]
        }
        
    }
 

}
