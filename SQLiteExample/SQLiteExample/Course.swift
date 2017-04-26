//
//  Course.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import Foundation

struct Course {
    
    let name: String
    
    var id: Int 
    
    var students: [String] = []
        
    let key: String
    
    init(name: String, key: String = "", id: Int) {
        
        self.key = key
        
        self.name = name
                
        self.id = id
    }
    
    
    
    func toAnyObject() -> Any {
        
        return [
            "name": name,
            "students": students
        ]
    }
}
