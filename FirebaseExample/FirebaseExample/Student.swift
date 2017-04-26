//
//  Student.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import Foundation
import Firebase

struct Student {
    
    let key: String
    
    let firstName: String
    
    let lastName: String
    
    let age: Int
    
    var courses: [String] = []
    
    let ref: FIRDatabaseReference?
    
    
    init(firstName: String, lastName: String, age: Int, key: String = "") {
        
        self.key = key
        
        self.firstName = firstName
        
        self.lastName = lastName
        
        self.age = age
        
        self.courses = []
        
        self.ref = nil
        
    }
    
    
    init(snapshot: FIRDataSnapshot) {
        
        key = snapshot.key
        
        let snapshotValue = snapshot.value! as! [String: AnyObject]
        
        firstName = snapshotValue["firstName"] as! String
        
        lastName = snapshotValue["lastName"] as! String
        
        age = snapshotValue["age"] as! Int
        
        courses = snapshotValue["courses"] as? [String] ?? []
        
        ref = snapshot.ref
    }
    
    
    func toAnyObject() -> Any {
        
        return [
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "courses": courses
        ]
    }
    
    
    func getIdentifier() -> String {
        return "\(firstName)\(lastName)"
    }
}
