//
//  Contact.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-20.
//

import Foundation

struct Contact: Codable {
    var name: String = ""
    var imageData: Data = Data()
}

class ContactList: ObservableObject {
    @Published var contacts = [Contact]()
    
}
