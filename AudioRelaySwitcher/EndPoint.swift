//
//  EndPoint.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-18.
//
import Foundation
import SwiftData

@Model
final class EndPoint{
    var name:String;
    var url:String;
    var type:String;
    var desc:String;
    
    @Relationship(deleteRule:.cascade)
    var relays:[Relay] = []
    
    init(name: String="blah", url: String="http://123.123.123", type:String="X8", desc:String="desc desc") {
        self.name = name
        self.url = url
        self.type = type
        self.desc = desc
        /*
        if ( false && type == "X8" ){
            print("!!! creating X8 object \(type)")
            relays.append(Relay.init(relayName: "Pin0", pinNumber: 0, state: false))
            relays.append(Relay.init(relayName: "Pin1", pinNumber: 1, state: false))
            relays.append(Relay.init(relayName: "Pin2", pinNumber: 2, state: false))
            relays.append(Relay.init(relayName: "Pin3", pinNumber: 3, state: false))
            relays.append(Relay.init(relayName: "Pin4", pinNumber: 4, state: false))
            relays.append(Relay.init(relayName: "Pin5", pinNumber: 5, state: false))
            relays.append(Relay.init(relayName: "Pin6", pinNumber: 6, state: false))
            relays.append(Relay.init(relayName: "Pin7", pinNumber: 7, state: false))
            //(0...7).map { idx in
               //    print("iter \(idx)")
                //var r = Relay.init(relayName: "Pin\(idx)", pinNumber: idx, state: false)
                //relays.append()
        }
         */
    }
}

