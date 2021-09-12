//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-12.
//

import SwiftUI
struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya and Toby")
        }
    }
}
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        Group {
            if sizeClass == .compact {
                VStack {
                    UserView()
                }
            }
            else {
                HStack {
                    UserView()
                }
            }
        }
        
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
