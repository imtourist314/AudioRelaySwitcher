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
    @State var relayMaps:Dictionary<String,[Relay]>
    @State var selectedEndpoint:EndPoint?
    
    var body: some View {
        NavigationStack() {
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
                            .onTapGesture {
                                selectedEndpoint = endPoint
                            }
                    }
                }
                
                Divider()
                
                // TODO: once clicking on an endpoint display the relay pattern here
                if ( selectedEndpoint != nil ){
                    Text("Selected \(selectedEndpoint!.name)")
                } else {
                    Text("Nothing selected")
                }
                
                Spacer()
                /*
                      var data = RelayMaps[endpointName]
                      ForEach(data){ relay in
                        Text(relay.name, relay.pin, relay.state)
                    }
                 */
                
            }
            Spacer()
            Text("At the bottom")
        }
    }
    
    func createEmptyRelayArray(endpointName:String){
        var newRelays:[Relay] = (1...8).map { idx in
            let elem = Relay.init(relayName: "Pin\(idx)", pinNumber: idx, state: false)
            newRelays[idx] = elem;
        }
        relayMaps[selectedEndpoint!.name] = newRelays;
    }
}

#Preview {
    SettingsView()
        .modelContainer(for:[EndPoint.self,Relay.self])
}
