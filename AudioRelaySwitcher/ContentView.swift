//
//  ContentView.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var toggleValue = 1
    @State private var showSettingsView:Bool = false
    @Query var endPoints:[EndPoint]
    @State var selectedEndpoint:EndPoint?

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors:[.gray,.white]),
                           startPoint: .topLeading,endPoint:.bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                // header at the top of the screen
                homeHeader
                
                List(selection:$selectedEndpoint){
                    ForEach(endPoints){ endPoint in
                        Text(endPoint.name)
                            .onTapGesture {
                                selectedEndpoint = endPoint
                                doSomethingToAll()
                            }
                    }
                }
                
                HStack{
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    

                    Text("Current: Rotel").font(.system(size:32,weight:.medium,design:.default))
                        .foregroundColor(.black)
                        .padding()
                }
                .padding(.bottom,40)

                Text("Toggle").font(.system(size:24,weight:.medium))

                Button(){
                   doSomething()
                } label: {
                    Text("Rotel")
                        .frame(width:200,height:40)
                        .background(Color.green)
                        .foregroundColor(Color.black)
                        .cornerRadius(3.0)
                }
                Button(){
                   doSomething()
                } label: {
                    Text("Sansui").frame(width:200,height:40)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(3.0)
                }
                Spacer()
            }
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
            .padding()
        }
    }
    
    func doSomethingToAll(){
        ForEach(selectedEndpoint!.relays){ relay in
            print("for toggle \(relay.relayName) to \(relay.state)")
            //let url = URL(string:"http://192.168.0.209/cmd?cb=cboutputPin0&v="+String(relay.state))!
            //callUrl(url)
        }
    }

    func doSomething() {
        print("Now doing something")
        // cmd?cb='+c+'&v='+v
        if ( self.toggleValue == 1 ){
            self.toggleValue = 0
        } else {
            self.toggleValue = 1
        }
        print("Making URL requests here!! \(toggleValue)")
        let url = URL(string:"http://192.168.0.209/cmd?cb=cboutputPin0&v="+String(toggleValue))!
        callUrl(url:url)
    }
    
    func callUrl(url:URL){
        var urlRequest = URLRequest(url:url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("no-cache",forHTTPHeaderField: "cache-control")
        URLSession.shared.dataTask(with:url){
            (data,response,error) in
            // do something
        }.resume()
    }
}

extension ContentView {
    private var homeHeader:some View {
        HStack {
            Button(){
                showSettingsView.toggle()
            } label: {
                Text("Settings")
            }
            Spacer()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[EndPoint.self])
}
