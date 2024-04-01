//
//  SettingsView.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import SwiftUI
import SwiftData

// Screen to see the endpoints and then within that the
// the range of relays patterns for each one
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss;
    @Environment(\.modelContext) private var modelContext;
    @State private var showAddEndPoint = false;
    @State private var showRelayPatterns = false;
    @Query var endPoints:[EndPoint]
    @State var selectedEndpoint:EndPoint?
    
    var body: some View {
        let stack = NavigationStack() {
            VStack(alignment:.leading,spacing:10){
                
                Text("Relay Endpoints")
                    .toolbar {
                        ToolbarItem(placement:.topBarLeading) {
                            Button("Cancel"){
                                dismiss()
                            }
                        };
                        ToolbarItem {
                            Button(action:{
                                showAddEndPoint.toggle()
                            }, label:{
                                Label("Add Item",systemImage: "plus")
                            })
                        }
                    }
                    .sheet(isPresented: $showAddEndPoint, content: {
                        // if above + is clicked then show the dialog to allow for addition of end point
                        NavigationStack {
                            CreateEndPointView()
                        }
                        .presentationDetents([.medium])
                })
                
                
                // list of the endpoints
                    // List the endpoints here
                List(selection:$selectedEndpoint){
                    ForEach(endPoints){ endPoint in
                        Text(endPoint.name)
                            .listRowBackground((endPoint.name=="Sansui") ? Color.red: Color.green)
                            .onTapGesture {
                                selectedEndpoint = endPoint
                            }
                    }
                    .onDelete(perform: deleteEndpoint)
                }
                .frame(maxHeight:250)
                
                Divider()
                
                //if ( selectedEndpoint != nil && createEmptyRelayArray(endpointName: selectedEndpoint!.name) ){
                if ( selectedEndpoint != nil ){
                    VStack(){
                        Section{
                            Text("\(selectedEndpoint!.name)/Number of relays: \(selectedEndpoint!.relays.count)")
                            // ForEach($selectedEndpoint!.relays.sorted(by:{$0.relayName<$1.relayName})){ relay in
                            List{
                            ForEach(selectedEndpoint!.relays.sorted(by:{$0.relayName<$1.relayName})){ relay in
                                Toggle(isOn:Bindable(relay).state){
                                    Text("\(relay.relayName)")
                                }
                            }
                            }
                        }
                    }
                } else {
                    Text("Nothing selected")
                }
                
            }
            Spacer()
        }
        
        return stack
    }
    
    func deleteEndpoint( indexSet:IndexSet){
        for index in indexSet {
            let endPoint = endPoints[index]
            modelContext.delete(endPoint)
        }
    }
}

#Preview {
    SettingsView()
        .modelContainer(for:[EndPoint.self])
}
