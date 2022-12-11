//
//  MainWindowController.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import AppKit

class MainWindowController: NSWindowController, NSWindowDelegate {
    
    // MARK: Window Properties
    
    var splitVC: NSSplitViewController {
        contentViewController as! NSSplitViewController
    }
    
    var sidePanelController: SidePanelViewController {
        splitVC.splitViewItems[0].viewController as! SidePanelViewController
    }
    
    /**
     * The graph shown in this view
     */
    var graphViewController: GraphViewController {
        splitVC.splitViewItems[1].viewController as! GraphViewController
    }
    
    // MARK: Window Controller
    
    /**
     * Called when the window is starting to be resized
     */
    func windowWillStartLiveResize(_ notification: Notification) {
        graphViewController.windowResizingStarted()
    }
    
    /**
     * Called when the window has resized
     */
    func windowDidEndLiveResize(_ notification: Notification) {
        graphViewController.windowResizingEnded()
    }
    
    // MARK: Actions
    
    func magSwitchUpdated(to showMagnitude: Bool) {
        graphViewController.showMagnitudeUpdated(to: showMagnitude)
    }
    
    @IBAction func leftTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3 / sidePanelController.shiftSensitivity
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: -amount, verticalShift: 0)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func rightTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3 / sidePanelController.shiftSensitivity
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: amount, verticalShift: 0)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func upTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3 / sidePanelController.shiftSensitivity
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: 0, verticalShift: amount)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func downTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3 / sidePanelController.shiftSensitivity
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: 0, verticalShift: -amount)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        graphViewController.funcWindow = graphViewController.funcWindow.scaled(horizontal: 0.8 / sidePanelController.zoomSensitivity, vertical: 0.8 / sidePanelController.zoomSensitivity)
        graphViewController.graphFunction()
    }
    
    @IBAction func zoomOut(_ sender: Any) {
        graphViewController.funcWindow = graphViewController.funcWindow.scaled(horizontal: 1.2 * sidePanelController.zoomSensitivity, vertical: 1.2 * sidePanelController.zoomSensitivity)
        graphViewController.graphFunction()
    }
    
    

}

