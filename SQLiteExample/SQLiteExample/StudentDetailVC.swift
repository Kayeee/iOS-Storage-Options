//
//  StudentDetailVC.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import UIKit

class StudentDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CourseSelectedDelegate {

    @IBOutlet weak var nameField: UILabel!
    
    @IBOutlet weak var ageField: UILabel!
    
    @IBOutlet weak var coursesTable: UITableView!
    
    
    var student: Student! = nil
    var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.text = "\(student.firstName) \(student.lastName)"
        
        ageField.text = "\(student.age)"
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        courses = DatabaseController.getCourses(for: student)
        coursesTable.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    // MARK: - Actions

    @IBAction func deleteAction(_ sender: Any) {
        DatabaseController.deleteStudent(student_id: student.id)
        let _ = navigationController?.popViewController(animated: true)
    }


    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coursesTable.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = courses[indexPath.row].name
        
        return cell
    }

    
    func didSelectCourse(data: Course){
        
        DatabaseController.addCourseForStudent(student: student, course: data)
        
        coursesTable.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ClassesTableVC
        
        dest.delegate = self
    }

}
