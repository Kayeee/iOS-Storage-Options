//
//  DatabaseController.swift
//  FirebaseExample
//
//  Created by Kevin on 3/21/17.
//  Copyright © 2017 Kevin Everly All rights reserved.
//

import Foundation
import SQLite

class DatabaseController: NSObject {
    
    static var _db: Connection!
    static var _students: Table!
    static var _courses: Table!
    static var _relations: Table!
    
    static var _firstName: Expression<String>!
    static var _lastName: Expression<String>!
    static var _age: Expression<Int>!
    
    static var _courseName: Expression<String>!
    
    static var _id: Expression<Int>!
    static var _student_id: Expression<Int>!
    static var _course_id: Expression<Int>!
    
    
    class func initDatabase() {
        do {
            DatabaseController._db = try Connection("/Users/kevin/Documents/Xcode Projects/Playgrounds/SQLiteExample/student.sqlite3")
            print("connection successful")
            
            //Students Table
            _id = Expression<Int>("id")
            _students = Table("students")
            _firstName = Expression<String>("firstName")
            _lastName = Expression<String>("lastName")
            _age = Expression<Int>("age")
            
            try DatabaseController._db.run(_students.create(temporary: true) { t in
                t.column(_id, primaryKey: .autoincrement)
                t.column(_firstName)
                t.column(_lastName)
                t.column(_age)
            })
            
            //Courses Table
            _courses = Table("courses")
            _courseName = Expression<String>("name")
            
            try DatabaseController._db.run(_courses.create(temporary: true){ t in
                t.column(_id, primaryKey: .autoincrement)
                t.column(_courseName)
            })
            
            //Student-Course Relations table
            _relations = Table("realtions")
            _student_id = Expression<Int>("student_id")
            _course_id = Expression<Int>("course_id")
            
            try DatabaseController._db.run(_relations.create(temporary: true){t in
                t.column(_id, primaryKey: true)
                t.column(_student_id, references: _students, _id)
                t.column(_course_id, references: _courses, _id)
            })
        
        
        } catch {
            print("can't open connection \(error)")
        }
    }
    
    
    class func newStudent(firstName: String, lastName: String, age: Int) -> Int{
        
        let insert = _students.insert(_firstName <- firstName, _lastName <- lastName, _age <- age)
        var id = -1
        do {
            id = Int(try _db.run(insert))
            
            
        } catch {
            print("ERROR ADDING STUDENT")
        }
        return id
    }
    
    
    class func newCourse(courseName: String) -> Int{
        let insert = _courses.insert(_courseName <- courseName)
        var id = -1
        print("Insert: \(insert)")
        do {
            id = Int(try _db.run(insert))
        } catch {
            print("ERROR ADDING COURSE")
        }
        return id
    }
    
    
    class func addRelation(student_id: Int, course_id: Int){
        let insert = _relations.insert(_student_id <- student_id, _course_id <- course_id)
        
        do {
            try _db.run(insert)
            
            for relation in try _db.prepare(_relations){
                print("id: \(relation[_id]), student_id: \(relation[_student_id]), course_id: \(relation[_course_id])")
            }
        } catch {
            print("ERROR ADDING RELATION")
        }
    }
    
    
    class func deleteStudent(student_id: Int){
        do {
            let student = _students.filter(_id == student_id)
            try _db.run(student.delete())
        } catch {
            print("ERROR ON DELETE")
        }
    }
    
    
    class func deleteCourse(course_id: Int) {
        do {
            let course = _courses.filter(_id == course_id)
            try _db.run(course.delete())
        } catch {
            print("ERROR ON DELETE")
        }
    }
    
    
    class func getAllStudents() -> [Student] {
        var students: [Student] = []
        do {
            for student in try _db.prepare(_students){
                let studentObj = Student(firstName: student[_firstName], lastName: student[_lastName], age: student[_age], id: student[_id])
                students.append(studentObj)
            }
        } catch {
            print("ERROR")
        }
        return students
    }
    
    
    class func addCourseForStudent(student: Student, course: Course) {
        self.addRelation(student_id: student.id, course_id: course.id)
    }
    
    
    class func getAllCourses() -> [Course] {
        var courses: [Course] = []
        do {
            for course in try _db.prepare(_courses) {
                let courseObj = Course(name: course[_courseName], id: course[_id])
                courses.append(courseObj)
            }
        } catch {
            print ("ERROR")
        }
        return courses
    }
    
    class func getCourses(for student: Student) -> [Course]{
        let query = _relations.select(_course_id).filter(_student_id == student.id)
        var coursesList: [Course] = []
        do{
            var courseIDs: [Int] = []
            for course in try _db.prepare(query){
                courseIDs.append(course[_course_id])
            }
            
            for id in courseIDs {
                let courses = _courses.filter(_id == id)
                for row in try _db.prepare(courses) {
                    coursesList.append(Course(name: row[_courseName], id: row[_id]))
                }
            }
        } catch {
            
        }
        print(coursesList)
        return coursesList
    }
}
