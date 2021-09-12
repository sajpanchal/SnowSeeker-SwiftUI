//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: Text("New Secondary")) {
            Text("Hello, world!")
            }
                .navigationBarTitle("primary")
            Text("Secondary")
        }
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
