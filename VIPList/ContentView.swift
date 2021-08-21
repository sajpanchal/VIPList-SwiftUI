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
    @State var showNameText = false
    @State var showButton = false
    //pass this image to ImagePicker.
    @State var inputImage: UIImage?
    @State var showTextField = false
    @State var showAlert = false
    @State var contact: Contact = Contact()
    @ObservedObject var contactList: ContactList = ContactList()
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Picture:")) {
                    VStack {
                        image?
                            .resizable()
                            .frame(width: 300, height: 300, alignment: .top)
                        Group {
                            Button("Upload") {
                                showingPicker = true
                            }
                            .frame(width: 100, height: 30)
                            .background(Color.gray)
                            .cornerRadius(3.0)
                            .foregroundColor(.black)
                            
                        }.frame(width: 100, height: 50, alignment: .bottom)
                    }
                }
                
                Section(header: Text("Name:")) {
                    TextField("Enter Name", text: $contact.name)
                        .padding()
                        .disabled(image == nil)
                }
                Button("Save") {
                    contactList.contacts.append(contact)
                    writeData()
                    showAlert = true
                    }
                    .disabled(contact.name.count < 2)
            }
            .navigationBarTitle("Create Contact")
            .navigationBarItems(trailing: NavigationLink(
                                    destination: ContactListView(contactList: contactList),
                                    label: {Text("List")}))
            .sheet(isPresented: $showingPicker, onDismiss: loadImage, content: {
                // pass the empty UIImage instance to Picker.
                //it will then return it with an selected image.
                
                ImagePicker(image: $inputImage)                
            })
            .alert(isPresented: $showAlert, content: {
                DispatchQueue.main.async {
                    contact.name = ""
                    image = nil
                }
               
                return Alert(title: Text("Success!"), message: Text("New Contact Saved."), dismissButton: .default(Text("Continue")))
                
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
                print("data written:", contactList.contacts)
            }
        }
        catch {
            print("writeData() error:",error.localizedDescription)
        }
    }
    
    func readData() {
        do {
            let decodedData = try Data(contentsOf: getDocumentsDirectory())
            let decoder = JSONDecoder()
            contactList.contacts = try decoder.decode([Contact].self, from: decodedData)
            print("data read:", contactList.contacts)
        }
        catch {
            print("readData() error:",error.localizedDescription)
        }
        
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
