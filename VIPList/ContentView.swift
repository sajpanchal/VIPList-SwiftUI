//
//  ContentView.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-19.
//

import SwiftUI

struct ContentView: View {
    @State var showingPicker = false
    @State var image: Image?
    //pass this image to ImagePicker.
    @State var inputImage: UIImage?
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                Button("Add Profile Pics") {
                    showingPicker = true
                }
            }.navigationBarTitle("VIPList")
            .sheet(isPresented: $showingPicker, onDismiss: loadImage, content: {
                // pass the empty UIImage instance to Picker.
                //it will then return it with an selected image.
                ImagePicker(image: $inputImage)
                
            })
            
           
        }
        
    }
    //convert the UIImage to Image and assign it to our SwiftUI Image.
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
