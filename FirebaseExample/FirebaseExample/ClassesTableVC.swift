//
//  ClassesTableVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import Firebase

protocol CourseSelectedDelegate {
    func didSelectCourse(data: String)
}

class ClassesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseAddedDelegate {

    @IBOutlet weak var coursesTable: UITableView!
    
    var courses: [Course] = []
    
    var ref: FIRDatabaseReference!
    
    var delegate: CourseSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference(withPath: "courses-items")
        
        
        
        ref.queryOrderedByKey().observe(.value, with: { snapshot in
            
            var newItems: [Course] = []
            
            for item in snapshot.children {
                
                newItems.append(Course(snapshot: item as! FIRDataSnapshot))
            }
            
            self.courses = newItems
            self.coursesTable.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coursesTable.reloadData()
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
        
        cell.textLabel?.text = courses[indexPath.row].name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectCourse(data: courses[indexPath.row].name)
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! AddClassVC
        dest.delegate = self
    }
    
    // MARK: - Protocalls
    func saveAddedClass(data: Course) {
        courses.append(data)
    }
}
