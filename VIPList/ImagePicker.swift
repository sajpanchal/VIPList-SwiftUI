//
//  File.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-19.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    // to dismiss the ImagePicker on selection of picture
    @Environment(\.presentationMode) var presentationMode
    // to attach the image selected to return it to SwiftUI content view.
    @Binding var image: UIImage?
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        // coordinator is set as a delegate to picker so that it will respond to SwiftUI events.
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        // when image is selected.
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // if the image is selected.
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage // set the image as UIImage of Picker property.
            }
            // dismiss the PickerController
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
}
