//
//  File.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-19.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    
}
