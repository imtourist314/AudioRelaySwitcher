//
//  RelayMap.swift
//  AudioRelaySwitcher
//
//  Created by Bik Dhaliwal on 2023-12-23.
//

import Foundation
import SwiftData

@Model
final class Relay {
    var relayName:String;
    var pinNumber:Int;
    var state:Bool;
    init(relayName:String="Pin0",pinNumber:Int=0,state:Bool=false){
        self.relayName = relayName;
        self.pinNumber = pinNumber;
        self.state = state;
    }
}
