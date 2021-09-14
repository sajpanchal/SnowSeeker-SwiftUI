//
//  FilterView.swift
//  SnowSeeker
//
//  Created by saj panchal on 2021-09-14.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var resortArray: Resorts
    @State var filterType: String
    var country = ["Austria","Canada","France","United States"]
    @State var selectedCountry = "Austria"
    var size = ["Small", "Average", "Large"]
    @State var selectedSize = "Small"
    var price = ["$","$$","$$$"]
    @State var selectedPrice = "$"
    var body: some View {
        VStack {
            
            if filterType == "country" {
                Picker("Please select a country", selection: $selectedCountry) {
                    ForEach(country, id:\.self) {
                        Text($0)
                    }
                }
            }
            else if filterType == "size" {
                Picker("Please select a size", selection: $selectedSize) {
                    ForEach(size, id:\.self) {
                        Text($0)
                    }
                }
            }
            else {
                Picker("Please select a price", selection: $selectedPrice) {
                    ForEach(price, id:\.self) {
                        Text($0)
                    }
                }
            }
            Button("Done") {
                resortArray.resorts = Bundle.main.decode("resorts.json")
                if filterType == "country" {
                    resortArray.resorts = resortArray.resorts.filter { resort in
                        resort.country == selectedCountry
                    }
                }
                else if filterType == "size" {
                    resortArray.resorts = resortArray.resorts.filter { resort in
                        if selectedSize == "Small" {
                            return resort.size == 1
                        }
                        else if selectedSize == "Average" {
                           return resort.size == 2
                        }
                        else {
                           return resort.size == 3
                        }
                    }
                }
                else {
                    resortArray.resorts = resortArray.resorts.filter { resort in
                        if selectedPrice == "$"{
                            return resort.price == 1
                        }
                        else if selectedPrice == "$$" {
                           return resort.price == 2
                        }
                        else  {
                           return resort.price == 3
                        }
                        
                    }
                }
                print(resortArray.resorts)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterType: "Country")
    }
}
