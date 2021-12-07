//
//  ViewController.swift
//  Acceleration_collection
//
//  Created by kawanaka masaki on 2021/12/02.
//

import UIKit
import CoreMotion
import Firebase

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var isStarted = false
    var data_array:[[Double]] = []
    var data_x:[Double] = []
    var data_y:[Double] = []
    var data_z:[Double] = []
    let db = Firestore.firestore()
    
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
        setAccFirebase()
    }
    
    
    
    func outputAccelData(acceleration: CMAcceleration){
        AccX.text = "AccX: " + String(format: "%04f", acceleration.x)
        AccY.text = "AccY: " + String(format: "%04f", acceleration.y)
        AccZ.text = "AccZ: " + String(format: "%04f", acceleration.z)
        data_x.append(acceleration.x)
        data_y.append(acceleration.y)
        data_z.append(acceleration.z)
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
    
    func setAccFirebase(){
        db.collection("AccResult").document("Acc_array").setData([
            "x": data_x,
            "y": data_y,
            "z": data_z
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    


}

