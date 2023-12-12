//
//  SettingsView.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header:Text("Target Device Address"), footer:Text("footer")){
                    Text("hi1")
                    Text("hi2")
                    Text("hi3")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    XMarkButton()
                }
            }
        }
    }
}

struct XMarkButton:View{
    @Environment(\.presentationMode) var presentationMode
    var body:some View {
        Button(action:{
            presentationMode.wrappedValue.dismiss()
        },label:{
            Image(systemName:"xmark").font(.headline)
        })
    }
}

#Preview {
    SettingsView()
}
