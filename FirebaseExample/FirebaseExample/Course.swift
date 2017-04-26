//
//  Course.swift
//  FirebaseExample
//
//  Created by Kevin on 2/7/17.
//  Copyright © 2017 Branch Cut. All rights reserved.
//

import Foundation
import Firebase

struct Course {
    
    let name: String
    
    var students: [String] = []
    
    let ref: FIRDatabaseReference?
    
    let key: String
    
    init(name: String, key: String = "") {
        
        self.key = key
        
        self.name = name
        
        ref = nil
    }
    
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        
        let snapshotValue = snapshot.value as! [String: AnyObject]
        
        name = snapshotValue["name"] as! String
        
        students = snapshotValue["Students"] as? [String] ?? []
        
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        
        return [
            "name": name,
            "students": students
        ]
    }
}
