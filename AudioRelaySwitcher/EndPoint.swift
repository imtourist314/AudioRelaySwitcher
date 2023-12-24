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
    
    init(name: String="blah", url: String="http://123.123.123", type:String="xx", desc:String="desc desc") {
        self.name = name
        self.url = url
        self.type = type
        self.desc = desc
    }
}

