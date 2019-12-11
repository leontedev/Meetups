//
//  Contacts.swift
//  Friends
//
//  Created by Mihai Leonte on 10/12/2019.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit

class Contacts: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var images: [UUID:UIImage] = [:]
    
    
    init() {
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
        let filename = getDocumentsDirectory().appendingPathComponent("SavedContacts")

        do {
            let data = try Data(contentsOf: filename)
            contacts = try JSONDecoder().decode([Contact].self, from: data)
            
            let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

            let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
            let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

            if let dirPath = paths.first {
                
                for contact in contacts {
                    let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent("\(contact.id)")
                    let image = UIImage(contentsOfFile: imageUrl.path)!
                    
                    self.images[contact.id] = image
                }
            }
            
        } catch {
            print("Unable to load saved data.")
        }
        
        
        
        
    }
}
