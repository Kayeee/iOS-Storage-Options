//
//  ClassesTableVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Kevin Everly. All rights reserved.
//

import UIKit

protocol CourseSelectedDelegate {
    func didSelectCourse(data: Course)
}

class ClassesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseAddedDelegate {

    @IBOutlet weak var coursesTable: UITableView!
    
    var courses: [Course] = []

    var delegate: CourseSelectedDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        courses = DatabaseController.getAllCourses()
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
        delegate?.didSelectCourse(data: courses[indexPath.row])
        
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
