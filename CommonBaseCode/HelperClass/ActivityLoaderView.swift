//
//  ActivityLoaderView.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

/// A custom loading view that displays a centered activity indicator with a semi-transparent background.
class ActivityLoaderView: UIView {
    
    /// The activity indicator displayed in the center of the view.
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    /// The color of the activity indicator. Changing this will update the indicator's color.
    var styleColor: UIColor = .white {
        didSet {
            activityIndicator.color = styleColor
        }
    }
    
    /// Initializes the view with a specific frame.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    /// Initializes the view from a storyboard or XIB.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    /// Configures the appearance and layout of the loader view.
    private func setupUI() {
        // Set semi-transparent black background to block user interaction and highlight the loader
        backgroundColor = UIColor(white: 0, alpha: 0.6)
        
        // Make the view cover the entire screen regardless of its initialization frame
        self.frame = UIScreen.main.bounds
        
        // Disable autoresizing mask translation so we can use Auto Layout
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // Start animating the activity indicator immediately
        activityIndicator.startAnimating()
        
        // Add the activity indicator to the center of the view
        addSubview(activityIndicator)
        
        // Center the activity indicator horizontally in the view
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        // Center the activity indicator vertically in the view
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

