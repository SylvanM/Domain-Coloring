//
//  SidePanelViewController.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 12/10/22.
//

import Cocoa

class SidePanelViewController: NSViewController {

    // MARK: Properties
    
    var window: MainWindowController!
    
    @IBOutlet weak var magnitudeSwitch: NSSwitch!
    
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
    
}
