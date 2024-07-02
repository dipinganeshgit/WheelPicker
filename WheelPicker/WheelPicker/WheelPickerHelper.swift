//
//  WheelPickerHelper.swift
//  WheelPicker
//
//  Created by Dipin Ganesh on 01/07/2024.
//

import UIKit
import SwiftUI

class WheelPickerHelper: NSObject {

    @objc static let WheelPickerMaXValue: String = "count"
    @objc static let WheelPickerInterval: String = "Steps"
    @objc static let WheelPickerSpacing: String = "spacing"
    @objc static let WheelPickerShowText: String = "showText"
    @objc static let WheelPickerMultiplier: String = "multipler"
    @objc static let WheelPickerUnits: String = "unit"

    
    static func loadWheelPickerin(parentView : UIView, inParentViewController: UIViewController, configuration : [String : Any]) -> WheelPickerContainer
    {
        //Config the Picker
       @State var wheelPickerConfig = Config()
        
        if let count = configuration[WheelPickerMaXValue] as? Int {
            wheelPickerConfig.count = count
        }
        if let steps = configuration[WheelPickerInterval] as? Int {
            wheelPickerConfig.steps = steps
        }
        if let spacing = configuration[WheelPickerSpacing] as? CGFloat {
            wheelPickerConfig.spacing = spacing
        }
        if let showText = configuration[WheelPickerShowText] as? Bool{
            wheelPickerConfig.showText = showText
        }
        if let multiplier = configuration[WheelPickerMultiplier] as? Int {
            wheelPickerConfig.multipler = multiplier
        }
        if let unit = configuration[WheelPickerUnits] as? String {
            wheelPickerConfig.unit = unit
        }
        
        //Load the Picker Container
        let wheelPicker = WheelPickerContainer(config: wheelPickerConfig, value: 10) { newValue in
            //Callback for the value change
            //Add your delegates here
            print("value changed to \(newValue)")
        }

        // Create the hosting controller with the SwiftUI view
        let hostingController = UIHostingController(rootView: wheelPicker)
        
        // Add the hosting controller as a child view controller
        inParentViewController.addChild(hostingController)
        parentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: inParentViewController)
        
        // Set constraints for the SwiftUI view to fill the parent view
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: parentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            
        ])
        
        return wheelPicker
    }
    
}
