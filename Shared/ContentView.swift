//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-12.
//

import SwiftUI
struct User: Identifiable {
    var id = "Saj Panchal"
}
struct ContentView: View {
    @State var selectedUser: User? = nil
    var body: some View {
        NavigationView {
            
            Text("Hello, world!")
                .onTapGesture {
                    self.selectedUser = User()
                }
                .alert(item: $selectedUser) { user in
                    Alert(title: Text(user.id))
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
