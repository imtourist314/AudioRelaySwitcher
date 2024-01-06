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
    @State var isAnimating = false

    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors:[.white,.gray]),startPoint:.topLeading,endPoint:.bottomTrailing).edgesIgnoringSafeArea(.all)
            VStack() {
                // header at the top of the screen
        //        homeHeader
                HStack {
                    Button(){
                        showSettingsView.toggle()
                    } label: {
                        Text("Settings")
                    }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    .padding(.leading,8)
                }
                
                List(endPoints,selection:$selectedEndpoint){ endPoint in
                    Text("\(endPoint.name)")
                         .onTapGesture {
                            selectedEndpoint = endPoint
                         }
                }
                .frame(maxHeight:400)
                
                Divider()
                
                if ( selectedEndpoint != nil ){
                    endPointDetails()
                } else {
                   Text("Select End Point")
                       .padding()
                }
                
                Spacer()
                Divider()
                
                Button(){
                    doSomethingToAll()
                } label :{
                    Text("Invoke")
                        .frame(width:200,height:40)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .disabled(false)
                }
            }
            .frame(alignment:.topLeading)
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
    
    func endPointDetails() -> some View {
        return VStack() {
            HStack(spacing:20) {
                Color.gray
                    .shadow(color:.primary,radius:0,x:2,y:2)
                    .overlay {
                        TextAnimate(text: selectedEndpoint!.name)
                        .padding(.leading,5)
                        
                        Text(selectedEndpoint!.type)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth:.infinity,alignment:.trailing)
                            .padding(.trailing,5)
                    }
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: 40)
                .padding(10)
            Text(selectedEndpoint!.url)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading,5)
           Text(selectedEndpoint!.desc)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading,5)
            
        }
        .animation(.easeIn(duration: 2.5), value: false)
    }
    
    func TextAnimate(text:String) -> some View {
        return Text(text)
                    .font(.title)
                    .opacity(isAnimating ? 1.0 : 0.0)
                    .animation(.easeIn(duration: 0.5), value: isAnimating)
                    .onAppear { isAnimating = true }
//                    .foregroundStyle(
 //                       Color.white.shadow(
  //                          .inner(color: .black, radius: 1, x: 0, y: 2)
   //                     )
//                    )
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
            .frame(alignment: .leading)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for:[EndPoint.self])
}
