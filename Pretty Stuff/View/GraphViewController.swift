//
//  ViewController.swift
//  Pretty Stuff
//
//  Created by Sylvan Martin on 8/29/22.
//

import Cocoa

class GraphViewController: NSViewController {

    // MARK: Properties
    
    @IBOutlet weak var graphView: NSImageView!
    @IBOutlet weak var overlayImage: OverlayView!
    
    var funcWindow = Function.window
    
    var shouldShowMagnitude = true
    var shouldShowAxes = true
    
    // MARK: View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        graphFunction()
    }
    
    // MARK: View Updates
    
    func windowResizingStarted() {
        releaseView()
    }
    
    func windowResizingEnded() {
        constrainView()
        graphFunction()
    }
    
    // MARK: View Functoins
    
    /**
     * Toggle showing the magnitude
     */
    func showMagnitudeUpdated(to showMagnitude: Bool) {
        shouldShowMagnitude = showMagnitude
        graphFunction()
    }
    
    func showAxesUpdated(to showAxes: Bool) {
        shouldShowAxes = showAxes
        graphFunction()
    }
    
    /**
     * Release the constraints on the graphView so that the view can be resized
     */
    func releaseView() {
        NSLayoutConstraint.deactivate(graphView.constraints)
    }
    
    /**
     * Reactivate constraints
     */
    func constrainView() {
        
        let topConstraint = NSLayoutConstraint(
            item: graphView as Any,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1,
            constant: 0
        )

        let leadingConstraint = NSLayoutConstraint(
            item: graphView as Any,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1,
            constant: 0
        )

        let bottomConstraint = NSLayoutConstraint(
            item: graphView as Any,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1,
            constant: 0
        )

        let trailingConstraint = NSLayoutConstraint(
            item: graphView as Any,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1,
            constant: 0
        )

        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    /**
     * Graphs the function accoring to the new window size
     */
    func graphFunction() {
        
        var vectorField = VectorField<Function.VectorType>(forFunction: Function.function, overWindow: funcWindow, forRect: graphView.bounds)
        
        let horizontalAxis  = Set<Function.VectorType>.horizontalAxis(width: 0.005)
        let verticalAxis    = Set<Function.VectorType>.verticalAxis(width: 0.005)
        
        if shouldShowAxes {
            vectorField.overlaySet(set: horizontalAxis, color: .black)
            vectorField.overlaySet(set: verticalAxis, color: .black)
        }
        
        let pixels = NSImageView.convertToPixels(for: vectorField, shouldShowMagnitude: shouldShowMagnitude)

        graphView.setPixels(pixels)

    }
    
    func resetView() {
        funcWindow = Function.window
        graphFunction()
    }

}

