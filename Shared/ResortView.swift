//
//  ResortView.swift
//  SnowSeeker
//
//  Created by saj panchal on 2021-09-12.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @Environment(\.horizontalSizeClass) var sizeClass
    @State var selectedFacility: String?
    @EnvironmentObject var favorites: Favorites
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                Group {
                    HStack {
                        if sizeClass == .compact {
                        Spacer()
                            VStack {
                            ResortDetailsView(resort: resort)
                            }
                            VStack {
                                SkiDetailsView(resort: resort)
                            }
                        Spacer()
                        }
                        else {
                          
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)                                
                           
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilities, id:\.self) { facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
            }
            Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                }
                else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .alert(item: $selectedFacility) {facility in
            Facility.alert(for: facility)
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: try! Resort(from: ContentView.example as! Decoder))
    }
}

extension String: Identifiable {
    public var id: String {
        self
    }
}
