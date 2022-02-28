//
//  ButtonViewController.swift
//  Components
//
//  Created by sky on 2/15/22.
//

import UIKit
import BaseComponent

class ButtonViewController: UIViewController {
    
    @IBOutlet weak var loadingButton: LoadingButton!

    @IBAction func loadingButtonTapped(_ sender: Any) {
        print(loadingButton.titleLabel?.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loadingButton.stopLoading()
        }
    }
}
