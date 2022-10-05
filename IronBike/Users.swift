//
//  Users.swift
//  IronBike
//
//  Created by MUYANGO Gael SHEMA on 10/04/2019.
//  Copyright © 2019 Fontys. All rights reserved.
//

import Foundation
import Firebase

struct Users {
    
    let ref: DatabaseReference?
    let key: String
    let name: String
    let position : String
    
    init(name: String,position : String = "", key: String = "") {
        self.ref = nil
        self.key = key
        self.name = name
        self.position = position
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let name = value["name"] as? String,
            let position = value["position"] as? String
            else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.name = name
        self.position = position
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "position": position,
        ]
    }
}

