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
    
    // tao them 1 UIView bang tay (segmentControl)
    var segmentControl3: SegmentControl!
    var segmentControl4: SegmentControlBig!
    
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
        // set constraint programmatically
        segmentControl3 = SegmentControl(frame: CGRect(x: 20, y: 148, width: UIScreen.main.bounds.width - 40, height: 44))
        self.view.addSubview(segmentControl3)
        segmentControl3.setItems(items: [("profile", UIImage(named: "ic_profile_filled")),
                                         ("limit", UIImage(named: "ic_limits")),
                                         ("settings", UIImage(named: "ic_settings_filled"))],
                                 iconAlignment: .forceRightToLeft) { index in
            print(index)
        }
        
        segmentControl4 = SegmentControlBig(frame: CGRect(x: 20, y: 212, width: UIScreen.main.bounds.width - 40, height: 44))
        self.view.addSubview(segmentControl4)
        segmentControl4.setItems(items: [("button1", nil), ("button2", nil)],
                                 iconAlignment: .forceRightToLeft) { index in
            print(index)
        }
    }
    
}
