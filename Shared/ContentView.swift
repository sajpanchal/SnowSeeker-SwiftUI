//
//  ContentView.swift
//  Shared
//
//  Created by saj panchal on 2021-09-12.
//

import SwiftUI

struct ContentView: View {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    @ObservedObject var resortArray = Resorts()
    @ObservedObject var favorites = Favorites()
    @State var showActionSheet = false
    @State var showFilterView = false
    @State var filterType = "country"
    @State var selectActionSheet = 0
    
    var body: some View {
        NavigationView {
            List(resortArray.resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 1))
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }.layoutPriority(1)
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort."))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: {
                self.showActionSheet = true
                selectActionSheet = 1
            }, label: {
                Text("Sort")
            }) , trailing: Button(action: {
                self.showActionSheet = true
                selectActionSheet = 2
            }, label: {
                Text("Filter")
            }))
            .actionSheet(isPresented: $showActionSheet, content: {
                if selectActionSheet == 1 {
                    return ActionSheet(title: Text("Sort Resorts"), message: Text("By:"), buttons: [
                                    .default(Text("default")) { sortResorts(parameter: "default")},
                                    .default(Text("Alphabetical")) { sortResorts(parameter: "alphabetical") },
                                    .default(Text("Country")) { sortResorts(parameter: "country") },
                                    .cancel()
                    ])
                }
                else {
                  return ActionSheet(title: Text("Filter Resorts"), message: Text("By:"), buttons: [
                                    .default(Text("Country")) {
                                        filterType = "country"
                                        
                                        print(filterType)
                                        showFilterView.toggle()
                                    },
                                    .default(Text("Size")) {
                                        filterType = "size"
                                        showFilterView.toggle()
                                        print(filterType)
                                    },
                                    .default(Text("Price")) {
                                        filterType = "price"
                                        showFilterView.toggle()
                                        print(filterType)
                                    },
                                    .cancel()
                  ])
                }
                
            })
            .sheet(isPresented: $showFilterView) {
                FilterView(filterType: filterType).environmentObject(resortArray)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
    func sortResorts(parameter: String) {
        resortArray.resorts =  Bundle.main.decode("resorts.json")
        resortArray.resorts.sort {
            if parameter == "alphabetical" {
           return $0.name < $1.name
            }
            else if parameter == "country" {
              return $0.country < $1.country
            }
            else {
                return $0.imageCredit < $1.imageCredit
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
