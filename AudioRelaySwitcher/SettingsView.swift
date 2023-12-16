//
//  SettingsView.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-12.
//

import SwiftUI

struct EndPoint:Identifiable {
    let id=UUID();
    var name:String;
    var url:String;
    var type:String;
    var desc:String;
}

struct SettingsView: View {
    @State private var isShowingAddEndpoint = false;
    @State private var name:String = "";
    @State var newEndPoint:EndPoint = EndPoint(name:"Switcher1",url:"http://www1",type:"Switcher",desc:"blahbah");
    var endPoints:[EndPoint] = [];
    var xxendPoints:[EndPoint] = [
        EndPoint(name:"Switcher1",url:"http://www1",type:"Switcher",desc:"blahbah"),
        EndPoint(name:"Switcher2",url:"http://www2",type:"Switcher2",desc:"zzzz")
    ];
        //UserDefaults.standard..array(forKey:"endPoints")
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                if ( endPoints.isEmpty ) {
                    Text("No endpoints");
                    Button(){
                        withAnimation{
                            isShowingAddEndpoint.toggle();
                        }
                    } label: {
                        Text("Add")
                            .frame(width:200,height:40)
                            .background(Color.green)
                            .foregroundColor(Color.black)
                            .cornerRadius(3.0)
                    }
                    
                    if ( isShowingAddEndpoint ){
                        Section(header:Text("Add"),footer:Text("footer")){
                            VStack(){
                                Form {
                                    TextField("Name",text:$newEndPoint.name);
                                    TextField("Url",text:$newEndPoint.url);
                                    TextField("Type",text:$newEndPoint.type);
                                    TextField("Desc",text:$newEndPoint.desc);
                                }
                            }
                        }
                    }
                    
                } else {
                    List {
                        ForEach(endPoints){ endPoint in
                            Text("Endpoint \(endPoint.name)");
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    XMarkButton();
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Text("Settings").bold().frame(maxWidth:.infinity,alignment:.trailing);
                }
            }
            
            /*
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
             */
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
