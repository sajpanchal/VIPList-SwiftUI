//
//  Contact.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-20.
//

import Foundation
import MapKit
struct Contact: Codable {
    var name: String = ""
    var imageData: Data = Data()
    var coordinates = Coordinates()
}

struct Coordinates: Codable {
    var lat = CLLocationCoordinate2D().latitude
    var long = CLLocationCoordinate2D().longitude

}

class ContactList: ObservableObject {
    @Published var contacts = [Contact]()
    
}
