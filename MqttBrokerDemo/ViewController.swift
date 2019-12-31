//
//  ViewController.swift
//  MqttBrokerDemo
//
//  Created by Cevat BALABAN on 12/30/19.
//  Copyright © 2019 Cevat BALABAN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblBedroomTemperature: UILabel!
    @IBOutlet weak var lblKitchenTemperature: UILabel!
    @IBOutlet weak var txtTopic: UITextField!
    @IBOutlet weak var txtMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Mqtt.subscribeToTopic(topic: Mqtt.TOPIC_BEDROOM_TEMP)
        Mqtt.subscribeToTopic(topic: Mqtt.TOPIC_KITCHEN_TEMP)
        
        NotificationCenter.default.addObserver(self, selector: #selector(bedroomTempReceived(notification:)), name: NSNotification.Name(rawValue: Mqtt.NOTIFICATION_BEDROOM_TEMP), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(kitchenTempReceived(notification:)), name: NSNotification.Name(rawValue: Mqtt.NOTIFICATION_KITCHEN_TEMP), object: nil)
    }
    
    @objc func bedroomTempReceived(notification: NSNotification) {
        if let message = notification.userInfo?["message"] as? String {
            DispatchQueue.main.async {
                self.lblBedroomTemperature.text = "Bedroom Temperature: \(message)"
            }
        }
    }
    
    @objc func kitchenTempReceived(notification: NSNotification) {
        if let message = notification.userInfo?["message"] as? String {
            DispatchQueue.main.async {
                self.lblKitchenTemperature.text = "Kitchen Temperature: \(message)"
            }
        }
    }
    
    @IBAction func subscribeToTopicsButtonClicked(_ sender: Any) {
        Mqtt.subscribeToTopic(topic: Mqtt.TOPIC_BEDROOM_TEMP)
        Mqtt.subscribeToTopic(topic: Mqtt.TOPIC_KITCHEN_TEMP)
    }
    @IBAction func sendMessageToTopicButtonClicked(_ sender: Any) {
        if !txtTopic.text!.isEmpty && !txtMessage.text!.isEmpty{
            Mqtt.publishMessageToTopic(topic: txtTopic.text!, message: txtMessage.text!)
        }
    }
}

