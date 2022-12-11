//
//  SidePanelViewController.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 12/10/22.
//

import Cocoa
import Numerics

class SidePanelViewController: NSViewController {

    private let maxZoomFactor:  Double = 2
    private let maxShiftFactor: Double = 2
    
    // MARK: Properties
    
    var window: MainWindowController!
    
    @IBOutlet weak var magnitudeSwitch: NSSwitch!
    
    @IBOutlet weak var shiftSldier: NSSlider!
    
    @IBOutlet weak var zoomSlider: NSSlider!
    
    public var zoomSensitivity: Double {
        maxZoomFactor * zoomSlider.doubleValue / zoomSlider.maxValue
    }
    
    public var shiftSensitivity: Double {
        maxShiftFactor * shiftSldier.doubleValue / shiftSldier.maxValue
    }
    
    // MARK: View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        window = (view.window!.windowController as! MainWindowController)
    }
    
    // MARK: Actions
    
    @IBAction func magnitudeSwitchUpdated(_ sender: Any) {
        window.graphViewController.showMagnitudeUpdated(to: magnitudeSwitch.state == .on)
    }
    
    @IBAction func resetView(_ sender: Any) {
        window.graphViewController.resetView()
    }
    
    @IBAction func findRootsAndPoles(_ sender: Any) {
        let msg = NSAlert()
        msg.addButton(withTitle: "Find Them!")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = title ?? "The Argument Principle"
        msg.informativeText = "Enter the real and imaginary coordinate and radius of a circle, and we'll find zeros and poles inside that circle."

        let realCoord = NSTextField(frame: NSRect(x: 0, y: 56, width: 200, height: 24))
        let imagCoord = NSTextField(frame: NSRect(x: 0, y: 28, width: 200, height: 24))
        let radius = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        realCoord.placeholderString = "Real Coordinate"
        imagCoord.placeholderString = "Imaginary Coordinate"
        radius.placeholderString = "Radius"
        
        let stack = NSStackView(frame: NSRect(x: 0, y: 0, width: 200, height: 86))
    
        
        stack.addSubview(realCoord)
        stack.addSubview(imagCoord)
        stack.addSubview(radius)
        
        msg.accessoryView = stack
        
        let response: NSApplication.ModalResponse = msg.runModal()

        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            
            let real = Double(realCoord.stringValue)!
            let imag = Double(imagCoord.stringValue)!
            
            let radius = Double(radius.stringValue)!
            let center = Complex(real, imag)

            
            
            print("Looking for zeros \(radius) from \(center).")
            
        } else {
            print("User Canceled finding zeros and poles")
        }
    }
    
}
