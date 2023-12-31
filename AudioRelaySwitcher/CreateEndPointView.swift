//
//  EndPointView.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-18.
//

import SwiftUI
import SwiftData

struct CreateEndPointView: View {
    @Environment(\.dismiss) var dismiss;
    @Environment(\.modelContext) var modelContext;
    @State var endPoint:EndPoint = EndPoint.init(name:"",url:"",type:"X8",desc:"");
    
    var acceptedTypes = ["Relay X8","Relay X4","Relay X2","Relay X1"]
    
    var body:some View{
        List {
            TextField("Name",text:$endPoint.name)
                .font(.title)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            TextField("URL",text:$endPoint.url)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
                .listRowSeparator(.hidden)
            
            /*
            Picker("Type",selection:$endPoint.type){
                ForEach(self.acceptedTypes,id:\.self){
                    Text($0)
                }
            }
             */
            
            TextField("Type",text:$endPoint.type)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
                .listRowSeparator(.hidden)
            
            TextField("Description",text:$endPoint.desc)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing){
                Button("Save"){
                    modelContext.insert(endPoint)
                    createRelays()
                    dismiss()
                }
            }
            ToolbarItem(placement:.navigationBarLeading){
                Button("Cancel"){
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func createRelays(){
        print("Callining create relays for new endpoint \(endPoint.name) of type \(endPoint.type) with url: \(endPoint.url)")
        (0...7).map { idx in
            endPoint.relays.append(Relay.init(relayName: "Relay\(idx)", pinNumber: idx, state: false))
        }
        print("Appended \(endPoint.relays.count) relays to endpoint: \(endPoint.name)")
    }
}

#Preview {
    CreateEndPointView()
        .modelContainer(for:[EndPoint.self,Relay.self])
}
