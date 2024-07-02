//
//  Config.swift
//  WheelPicker
//
//  Created by Dipin Ganesh on 02/07/2024.
//

import UIKit
import Combine

class Config: ObservableObject {
    @Published var count : Int = 30
    @Published var steps : Int = 10
    @Published var spacing : CGFloat = 5
    var showText : Bool = true
    @Published var multipler : Int = 10
    var unit : String = ""
}
