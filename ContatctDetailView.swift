//
//  ContatctDetailView.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-21.
//

import SwiftUI
import MapKit
struct ContatctDetailView: View {
    @State var contact: Contact
     
    
    var annotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = contact.coordinates.lat
        annotation.coordinate.longitude = contact.coordinates.long
        return annotation
    }

    var body: some View {
        VStack {
            HStack {
                Text(contact.name)
                    .font(.largeTitle)
                Image(uiImage: UIImage(data: contact.imageData)!)
                    .resizable()
                    .scaledToFit()
            }
          
            MapViewSwiftUI(centerCoordinate: .constant(CLLocationCoordinate2D(latitude: contact.coordinates.lat, longitude: contact.coordinates.long)), annotation: annotation)
            
        }
    }
}

struct ContatctDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContatctDetailView(contact: Contact())
    }
}
