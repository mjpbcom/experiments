//
//  ViewController.swift
//  experiments
//
//  Created by Mariah Jessica Baysic on 7/12/21.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var circularProgress: CircularProgressView!
    var progress: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circularProgress.trackClr = UIColor.cyan
        circularProgress.progressClr = UIColor.purple
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
            if self.progress < 100 {
                self.progress += 1
                self.circularProgress.setProgressWithAnimation(duration: 1.0, value: self.progress)
            }
        }
    }

}

