//
//  Contact.swift
//  Friends
//
//  Created by Mihai Leonte on 10/12/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import Foundation

struct Contact: Codable, Hashable, Comparable {
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
    
    let id: UUID
    let name: String
}


