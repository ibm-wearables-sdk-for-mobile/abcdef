/*
*   © Copyright 2015 IBM Corp.
*
*   Licensed under the Mobile Edge iOS Framework License (the "License");
*   you may not use this file except in compliance with the License. You may find
*   a copy of the license in the license.txt file in this package.
*
*   Unless required by applicable law or agreed to in writing, software
*   distributed under the License is distributed on an "AS IS" BASIS,
*   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*   See the License for the specific language governing permissions and
*   limitations under the License.
*/

import UIKit
import CoreBluetooth
import IBMMobileEdge
import AVFoundation

class ViewController: UIViewController, ConnectionStatusDelegate{
    
    @IBOutlet weak var x: UILabel!
    @IBOutlet weak var y: UILabel!
    @IBOutlet weak var z: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var accelerometerSwitch: UISwitch!
    @IBOutlet weak var diconnectButton: UIButton!
    @IBOutlet weak var connectButton: UIButton!
    
    /*
    // Step 1. Create mobile edge controller and device connector
    var device:DeviceConnector = Gemsense()
    let controller = MobileEdgeController()
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.stopAnimating()
        diconnectButton.hidden = true
        
        /*
        // Step 4. set connection delegate
        controller.delegate = self
        */
        
        /*
        // Step 5. register updates to the UI
        controller.sensors.accelerometer.registerListener(updateAccelerometerUI)
        */
        
        /*
        // Step 6. register fall detection interpretation
        controller.registerInterpretation(FallDetection(), withListener: fallDetected)
        */
        
        /*
        // Step 7 (Optional)
        let classification = Classification()
        controller.registerInterpretation(classification)
        classification.loadGesturesByFilePath(["file_path"])
        classification.registerListener(gestureDetected)
        */
        
    }
    
    
    @IBAction func disconnectButtonClicked(sender: AnyObject) {
        /*
        // Step 2b. disconnect from the device
        device.disconnect()
        */
    }
    
    @IBAction func onConnectButtonClicked(sender: AnyObject) {
        spinner.startAnimating()
        
        /*
        // Step 2a. start connection to the device
        controller.connect(device)
        */
    }
    
    @IBAction func onAccelerometerSwitchChanged(sender: AnyObject) {
        
        /*
        // Step 3. turn on the accelerometer sensors on and off
        if (accelerometerSwitch.on){
            controller.sensors.accelerometer.on()
        }
        else{
            controller.sensors.accelerometer.off()
        }
        */
    }
    
    //notification about connection status change
    func connectionStatusChanged(deviceName: String, withStatus status: ConnectionStatus) {
        
        spinner.stopAnimating()
        switch status{
        case .Connected:
            connectButton.hidden = true
            diconnectButton.hidden = false
            
        case .Disconnected:
            showMobileEdgeDialog("Device Dissconected")
            connectButton.hidden = false
            diconnectButton.hidden = true
            
        case .BluetoothUnavailable:
            showMobileEdgeDialog("Bluetooth Unavailable")
            
            
        case .DeviceUnavailable:
            showMobileEdgeDialog("Device Unavailable")
        }
    }
    
    //this function will be called once a fall of the device is detected
    func fallDetected(additonalInfo: AnyObject!) {
        showMobileEdgeDialog("Falling movement of the device was detected!")
    }
    
    //will be called each time a gesture is detected
    func gestureDetected(additionalInfo: AnyObject!){
        let gestureName = additionalInfo["recognized"] as? String
        showMobileEdgeDialog("Gesture \(gestureName) was detected!");
    }
    
    //this function will be called every time the accelerometer data is changed
    func updateAccelerometerUI(data: AccelerometerData){
        x.text = String(format:"%.4f", data.x)
        y.text = String(format:"%.4f", data.y)
        z.text = String(format:"%.4f", data.z)
    }
    
    func showMobileEdgeDialog(message:String){
        let alert = UIAlertController(title: "Interconnect 2016", message: message, preferredStyle: .Alert)
        let continueAction = UIAlertAction(title: "Continue", style: .Default, handler: nil)
        alert.addAction(continueAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

