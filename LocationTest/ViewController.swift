//
//  ViewController.swift
//  LocationTest
//
//  Created by Sander on 17.01.17.
//  Copyright © 2017 Company. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        return manager
    }()
    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        updateUI()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
    }

    @IBAction func changeValue(_ sender: UISwitch) {
        
        locationManager.allowsBackgroundLocationUpdates = sender.isOn
    }
    
    func updateUI() {
        
        let lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
        locationManager.allowsBackgroundLocationUpdates = !lowPowerMode
        self.switch.isOn = !lowPowerMode
        self.switch.isEnabled = !lowPowerMode
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations \(locations)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
    }
}

