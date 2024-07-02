//
//  ViewController.swift
//  WheelPicker
//
//  Created by Dipin Ganesh on 01/07/2024.
//

import UIKit
import SwiftUI

class SwiftViewController: UIViewController {

    @IBOutlet weak var segCount: UISegmentedControl!
    @IBOutlet weak var segSteps: UISegmentedControl!
    @IBOutlet weak var segMultiplier: UISegmentedControl!
    @IBOutlet weak var sliderSpacing: UISlider!

    @IBOutlet weak var viewPicker: UIView!
    public var config : Config = Config()
    var wheelPicker : WheelPickerContainer = WheelPickerContainer(config: .init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        segCount.selectedSegmentIndex = 2
        segSteps.selectedSegmentIndex = 1
        segMultiplier.selectedSegmentIndex = 1
        sliderSpacing.value = 5

        let configuration = [WheelPickerHelper.WheelPickerMaXValue : getSelectedValueFromSegmentedControl(segControl: segCount) , WheelPickerHelper.WheelPickerInterval : getSelectedValueFromSegmentedControl(segControl: segSteps) , WheelPickerHelper.WheelPickerSpacing : sliderSpacing.value , WheelPickerHelper.WheelPickerShowText : true , WheelPickerHelper.WheelPickerMultiplier : getSelectedValueFromSegmentedControl(segControl: segMultiplier) , WheelPickerHelper.WheelPickerUnits : "kg"] as [String : Any]
        
        
        wheelPicker = WheelPickerHelper.loadWheelPickerin(parentView: viewPicker, inParentViewController: self, configuration: configuration)
    }
    
    func getSelectedValueFromSegmentedControl(segControl : UISegmentedControl) -> Int {
        if  let value = Int(segControl.titleForSegment(at: segControl.selectedSegmentIndex) as? String ?? "0") {
            return value
        }
        return 0
    }


    @IBAction func actionCountChanged(_ sender: Any) {
        if let segmentController = sender as? UISegmentedControl {
            let value = Int(segmentController.titleForSegment(at: segmentController.selectedSegmentIndex)!)
            wheelPicker.config.count = Int(value ?? 0)
            wheelPicker.value = wheelPicker.value
            
        }
    }
    
    @IBAction func actionStepsChanged(_ sender: Any) {
        if let segmentController = sender as? UISegmentedControl {
            let value = Int(segmentController.titleForSegment(at: segmentController.selectedSegmentIndex)!)
            wheelPicker.config.steps = Int(value ?? 0)
            wheelPicker.value = wheelPicker.value
        }
    }
    
    @IBAction func actionMultiplierChanged(_ sender: Any) {
        if let segmentController = sender as? UISegmentedControl {
            let value = Int(segmentController.titleForSegment(at: segmentController.selectedSegmentIndex)!)
            wheelPicker.config.multipler = Int(value ?? 0)
            wheelPicker.value = wheelPicker.value
        }
    }
    
    @IBAction func actionSpacingChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            let value = CGFloat(slider.value)
            wheelPicker.config.spacing = CGFloat(value ?? 0)
            wheelPicker.value = wheelPicker.value
        }
    }
}

