//
//  ContentView.swift
//  VIPList
//
//  Created by saj panchal on 2021-08-19.
//

import SwiftUI

struct ContentView: View {
    @State var showingPicker = false
    var body: some View {
        NavigationView {
            VStack {
               
                Button("Add Profile Pics") {
                    showingPicker = true
                }
            }.navigationBarTitle("VIPList")
            .sheet(isPresented: $showingPicker, content: {
                ImagePicker()
            })
           
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
