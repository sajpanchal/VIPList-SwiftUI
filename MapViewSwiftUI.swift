//
//  MapViewSwiftUI.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-21.
//

import SwiftUI
import MapKit
struct MapViewSwiftUI: UIViewRepresentable {
    
    // update the centerCoordinate of this instance
    @Binding var centerCoordinate: CLLocationCoordinate2D
    // pinned location
    var annotation: MKPointAnnotation
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    typealias UIViewType = MKMapView
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)
        return mapView
    }
    // update the annotation.
    func updateUIView(_ uiView: MKMapView, context: Context) {
        for annotation in uiView.annotations {
            uiView.removeAnnotation(annotation)
        }
        uiView.addAnnotation(annotation)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewSwiftUI
        init(_ parent: MapViewSwiftUI) {
            self.parent = parent
        }
        // method will be called every time new custom annotation is created.
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        // method will be called everytime our mapview is scrolled, zoomed or touched.'
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }    
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapViewSwiftUI(centerCoordinate: .constant(MKPointAnnotation.example.coordinate), annotation: MKPointAnnotation.example)
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Waterloo"
        annotation.subtitle = "Home Town"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 43.46, longitude: -80.51)
        return annotation
    }
}
