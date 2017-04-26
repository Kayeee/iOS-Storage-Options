//
//  StudentDetailVC.swift
//  CoreDataExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import CoreData

class StudentDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var classTV: UITableView!
    
    
    var student: Student? = nil
    
    var courses: [Course] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(student!.firstName!) \(student!.lastName!)"
        
        ageLabel.text = "\(student!.age)"
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        //change courses from NSSet to Array
        courses = (student?.courses)!.allObjects as! [Course]
        
        classTV.reloadData()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    @IBAction func deleteAction(_ sender: Any) {
        
        DatabaseController.getContext().delete(student!)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = courses[indexPath.row].courseName
        
        return cell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let classTableVC = segue.destination as! ClassesTableVC
        
        classTableVC.student = student
    }
 

}
