//
//  GraphWindowDelegate.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import AppKit

class GraphWindowDelegate: NSWindowController, NSWindowDelegate {
    
    // MARK: Window Properties
    
    /**
     * The graph shown in this view
     */
    var graphViewController: GraphViewController {
        contentViewController as! GraphViewController
    }
    
    // MARK: Window Controller
    
    /**
     * Called when the window is about to resize
     */
    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        
        // we want to fix the aspect ratio
        
        let aspectRatio = Function.window.aspectRatio
        
        let heightAdjusted  = NSSize(width: (frameSize.height * CGFloat(aspectRatio)), height: frameSize.height)
        let widthAdjusted   = NSSize(width: frameSize.width, height: frameSize.width / CGFloat(aspectRatio))
            
        return sender.frame.height != frameSize.height ? heightAdjusted : widthAdjusted
    }

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
    
    @IBAction func leftTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: -amount, verticalShift: 0)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func rightTranslate(_ sender: Any) {
        var amount = graphViewController.funcWindow.horizontal.upperBound - graphViewController.funcWindow.horizontal.lowerBound
        amount /= 3
        
        graphViewController.funcWindow = graphViewController.funcWindow.shifted(horizontalShift: amount, verticalShift: 0)
        
        graphViewController.graphFunction()
    }
    
    @IBAction func zoomIn(_ sender: Any) {
        graphViewController.funcWindow = graphViewController.funcWindow.scaled(horizontal: 0.8, vertical: 0.8)
        graphViewController.graphFunction()
    }
    
    @IBAction func zoomOut(_ sender: Any) {
        graphViewController.funcWindow = graphViewController.funcWindow.scaled(horizontal: 1.2, vertical: 1.2)
        graphViewController.graphFunction()
    }
    
    

}

