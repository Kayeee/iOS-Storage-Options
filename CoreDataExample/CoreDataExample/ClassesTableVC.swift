//
//  AddClassVC.swift
//  CoreDataExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit
import CoreData

class ClassesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var courses: [Course] = []
    
    var student: Student?
    
    @IBOutlet weak var classesTV: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        let fetchRequest: NSFetchRequest<Course> = Course.fetchRequest()
        
        do {
            courses = try DatabaseController.getContext().fetch(fetchRequest)
            
            classesTV.reloadData()
            
        } catch {
            print("\(error)")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        student?.addToCourses(courses[indexPath.row])
        
        //DatabaseController.saveContext()
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
