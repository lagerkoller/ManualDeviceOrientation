//
//  ViewController.swift
//  ManualDeviceOrientation
//
//  Created by Johannes Luderschmidt on 13.06.18.
//  Copyright © 2018 Johannes Luderschmidt. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var orientationLabel: UILabel!
    let motionManager = CMMotionManager()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        motionManager.startAccelerometerUpdates()
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) {
                (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    let rotation = atan2(acceleration.x, acceleration.y) - .pi
                    if rotation <= -1.75 * .pi  || rotation > -0.25 * .pi {
                        self.orientationLabel.text = "Portrait up"
                    } else if rotation <= -0.25 * .pi  && rotation > -0.75 * .pi {
                        self.orientationLabel.text = "Landscape right"
                    } else if rotation <= -0.75 * .pi  && rotation > -1.25 * .pi {
                        self.orientationLabel.text = "Portrait down"
                    } else if rotation <= -1.25 * .pi  && rotation > -1.75 * .pi {
                        self.orientationLabel.text = "Landscape left"
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        motionManager.stopAccelerometerUpdates()
    }

    


}

