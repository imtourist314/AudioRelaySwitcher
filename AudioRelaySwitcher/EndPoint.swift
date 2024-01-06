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
    
    init(name: String="Endpoint Name", url: String="http://192.168.0.209/cmd?cb=cboutputPin0&", type:String="X8", desc:String="Endpoint Description") {
        self.name = name
        self.url = url
        self.type = type
        self.desc = desc
    }
}

