//
//  Student.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import Foundation

struct Student {
    
    let key: String
    
    let firstName: String
    
    let lastName: String
    
    let age: Int
    
    var courses: [String] = []
    
    var id: Int
    
    
    
    init(firstName: String, lastName: String, age: Int, key: String = "", id: Int) {
        
        self.key = key
        
        self.firstName = firstName
        
        self.lastName = lastName
        
        self.age = age
        
        self.courses = []
                
        self.id = id
        
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
