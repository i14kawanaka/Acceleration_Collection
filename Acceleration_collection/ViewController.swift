//
//  ViewController.swift
//  Acceleration_collection
//
//  Created by kawanaka masaki on 2021/12/02.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var isStarted = false
    var data_array:[[Double]] = []
    
    @IBOutlet weak var AccX: UILabel!
    @IBOutlet weak var AccY: UILabel!
    @IBOutlet weak var AccZ: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startAccelerometer()
    }
    
    @IBAction func startButton(_ sender: Any) {
        startAccelerometer()
    }
    
    @IBAction func stopButton(_ sender: Any) {
        stopAccelerometer()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
    
    
    func outputAccelData(acceleration: CMAcceleration){
        AccX.text = "AccX: " + String(format: "%04f", acceleration.x)
        AccY.text = "AccY: " + String(format: "%04f", acceleration.y)
        AccZ.text = "AccZ: " + String(format: "%04f", acceleration.z)
        data_array.append([acceleration.x,acceleration.y,acceleration.z])
        
    }
    
    func stopAccelerometer(){
        if (motionManager.isAccelerometerAvailable){
            motionManager.stopAccelerometerUpdates()
        }
        isStarted = false
        print(data_array)
    }
    
    func startAccelerometer(){
        data_array = []
        if(motionManager.isAccelerometerAvailable){
            motionManager.accelerometerUpdateInterval = 1
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler:{(accelData: CMAccelerometerData?, errorOC: Error?) in self.outputAccelData(acceleration: accelData!.acceleration
            )})
        }
    }
    
    


}

