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
            LinearGradient(gradient: Gradient(colors:[.white,.gray]),
                           startPoint: .topLeading,endPoint:.bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing:10) {
                // header at the top of the screen
                homeHeader
                
                List(selection:$selectedEndpoint){
                    ForEach(endPoints){ endPoint in
                        Text("\(endPoint.name) (\(endPoint.type))")
                            .onTapGesture {
                                selectedEndpoint = endPoint
                            }
                    }
                }
                
                Section {
                    if ( selectedEndpoint != nil ){
                        Text("\(selectedEndpoint!.name) \(selectedEndpoint!.desc)")
                    } else {
                        Text("Please Select")
                    }
                    Button(){
                        doSomethingToAll()
                    } label :{
                        Text("Invoke")
                            .frame(width:200,height:40)
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(3)
                    }
                    
                }
                
            .padding()
            }
            .frame(width:400).background(.orange)
            .sheet(isPresented: $showSettingsView, content: {
                SettingsView()
            })
        }
    }
    
    func doSomethingToAll(){
        selectedEndpoint!.relays.forEach{ relay in
            var state:String = "0"
            if ( relay.state ){
                state = "1"
            }
            let url = URL(string:"http://192.168.0.209/cmd?cb=cboutputPin"+String(relay.pinNumber)+"&v="+state)!
            callUrl(url:url)
            Thread.sleep(forTimeInterval: 0.1)
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
        print("Call to url: "+url.absoluteString)
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
