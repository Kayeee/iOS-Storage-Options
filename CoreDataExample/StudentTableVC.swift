 //
//  StudentTableVC.swift
//  CoreDataExample
//
//  Created by Kevin on 2/6/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import CoreData

class StudentTableVC: UITableViewController {

    var students: [Student] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            
            students = searchResults
            
            tableView.reloadData()
            
        } catch {
            print("No Students Found")
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return students.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let student = students[indexPath.row]
        
        cell.textLabel?.text = "\(student.firstName!) \(student.lastName!)"
        cell.detailTextLabel?.text = "Age: \(student.age)"

        return cell
    }



    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addStudent"{
            
            _ = segue.destination as! AddStudentVC
            
        } else {
            let dest = segue.destination as! StudentDetailVC
            
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            
            dest.student = students[(path?.row)!]
        }

    }
 

}
