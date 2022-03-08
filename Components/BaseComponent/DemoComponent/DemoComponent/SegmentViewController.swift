//
//  SegmentViewController.swift
//  DemoComponent
//
//  Created by sky on 3/7/22.
//

import BaseComponent
import UIKit

class SegmentViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: SegmentControl!
    @IBOutlet weak var segmentControl2: SegmentControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        segmentControl.setItems(items: [("button1", nil), ("button2", nil)], completion: { index in
            print(index)
        })
        segmentControl2.setItems(items: [("profile", UIImage(named: "ic_profile_filled")),
                                         ("limit", UIImage(named: "ic_limits")),
                                         ("settings", UIImage(named: "ic_settings_filled"))],
                                 completion: { index in
            print(index)
        })
    }

}
