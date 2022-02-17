//
//  LoadingButton.swift
//  Components
//
//  Created by sky on 2/16/22.
//

import UIKit

open class LoadingButton: PrimaryButton {
    
    let progressView: ProgressView = {
        let progress = ProgressView(colors: [.black], lineWidth: 3)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    var currentButtonText: String?
    
    public override func setup() {
        super.setup()
        setupProgressView()
        currentButtonText = titleLabel?.text
    }
    
    private func setupProgressView() {
        
        self.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor
                .constraint(equalTo: self.centerXAnchor),
            progressView.centerYAnchor
                .constraint(equalTo: self.centerYAnchor),
            progressView.widthAnchor
                .constraint(equalToConstant: 24),
            progressView.heightAnchor
                .constraint(equalTo: self.progressView.widthAnchor)
        ])
        
    }
    
    open override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        showLoading()
        return super.beginTracking(touch, with: event)
    }
    
    open override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        // do nothing
    }
    
    open override func cancelTracking(with event: UIEvent?) {
        // do nothing
    }
    
    public func showLoading() {
        setTitle("", for: .normal)
        progressView.startAnimating()
    }
    
    public func stopLoading() {
        if progressView.isAnimating == false { return }
        setTitle(currentButtonText, for: .normal)
        progressView.stopAnimating()
        animateToNormal()
    }
}

