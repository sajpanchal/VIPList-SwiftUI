//
//  ContactListView.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-20.
//

import SwiftUI

struct ContactListView: View {
    @State var contactList: ContactList
    var body: some View {
        List(contactList.contacts, id: \.name) { contact in
            HStack {
            
                Image(uiImage: UIImage(data: contact.imageData)!)
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .leading)
                Text(contact.name)
                    .frame(width: 200, height: 50, alignment: .center)
                    
                
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView(contactList: ContactList())
    }
}
