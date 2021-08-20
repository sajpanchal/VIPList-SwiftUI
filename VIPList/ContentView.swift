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
    @State var showTextField = false
    @State var contact: Contact = Contact()
    @ObservedObject var contactList: ContactList = ContactList()
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
            .sheet(isPresented: $showTextField, content: {
                VStack {
                    Section(header: Text("Enter the Contact name:")) {
                        TextField("Name", text: $contact.name)
                            .padding()
                            .frame(width: 300, height: 50, alignment: .center)
                            .background(Color.white)
                            .cornerRadius(5.0)
                    }
                    Button("Save") {
                        contactList.contacts.append(contact)
                        writeData()
                    }
                }
                
                
            })
           
        }.onAppear(perform: readData)
        
    }
    //convert the UIImage to Image and assign it to our SwiftUI Image.
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
        convertImageToData(uiImage: inputImage)
        showTextField = true
    }
    func convertImageToData(uiImage: UIImage) {
        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            contact.imageData = jpegData
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0].appendingPathComponent("contacts.txt")
    }
    func writeData() {
        let url = getDocumentsDirectory()
        
        do {
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(contactList.contacts) {
                try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func readData() {
        do {
            let decodedData = try Data(contentsOf: getDocumentsDirectory())
            let decoder = JSONDecoder()
            contactList.contacts = try decoder.decode([Contact].self, from: decodedData)
            
        }
        catch {
            
        }
        
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
