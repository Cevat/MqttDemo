//
//  Mqtt.swift
//  Gardener
//
//  Created by aa on 10/8/19.
//  Copyright © 2019 Emrecan Öztürk. All rights reserved.
//


import Foundation
import Moscapsule
import UIKit

class Mqtt {
    
    static var TOPIC_KITCHEN_TEMP = "mobiler/kitchen/temperature"
    static var NOTIFICATION_KITCHEN_TEMP = "NOTIFICATION_KITCHEN_TEMP"
    
    static var TOPIC_BEDROOM_TEMP = "mobiler/bedroom/temperature"
    static var NOTIFICATION_BEDROOM_TEMP = "NOTIFICATION_BEDROOM_TEMP"
    
    static var mqttClient: MQTTClient?
    
    
    class func publishMessageToTopic(topic: String, message: String){
        if isMqttConnected(){
            mqttClient?.publish(string: message, topic: topic, qos: 0, retain: false)
        }
    }
    
    class func subscribeToTopic(topic: String){
        if isMqttConnected(){
            mqttClient?.subscribe(topic, qos: 0)
        }
    }
    
    class func isMqttConnected() -> Bool{
        if let mqttClintParameter = mqttClient {
            if mqttClintParameter.isConnected {
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    
    class func StartMQTT() -> Void {
            
        moscapsule_init()
        
        //MQTT Client konfiguarsyon ayarlarını yapıyoruz.
        let RandomId : String = "IOS_\(UIDevice.current.identifierForVendor!.uuidString)"
        let mqttConfig = MQTTConfig(clientId: RandomId, host: "test.mosquitto.org", port: 1883, keepAlive: Int32.max)
        
        // Yayınlanan mesajları yakalayabileceğimiz callback fonksiyonunu yazıyoruz.
        mqttConfig.onMessageCallback = { mqttMessage in
            
            let receivedMessage = mqttMessage.payloadString!
            let receivedTopic = mqttMessage.topic
            
            DoBroadCast(topic: receivedTopic, message: receivedMessage)
        }
        
        //Bağlantıyı kuruyoruz.
        mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: true)
        
        //Baplantı gerçekleşmiş mi kontrol ediyoruz.
        print("Is Mqtt Connected: \(mqttClient?.isConnected)")
        
        //1.5 sn bekleyip, bağlantı gerçekleşmiş mi kontrol ediyoruz.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
           print("Is Mqtt Connected: \(mqttClient?.isConnected)")
        }
    }
    
    class func DoBroadCast(topic: String, message: String) -> Void {
        
        var notificationName = ""
        
        switch topic{
        case Mqtt.TOPIC_KITCHEN_TEMP:
            notificationName = Mqtt.NOTIFICATION_KITCHEN_TEMP
        case Mqtt.TOPIC_BEDROOM_TEMP:
            notificationName = Mqtt.NOTIFICATION_BEDROOM_TEMP
        default:
            break
        }
        
        if !notificationName.isEmpty{
            let data = ["message": message ] as [String : Any]
            NotificationCenter.default.post(name: Notification.Name(notificationName), object: nil, userInfo: data)
        }
    }
}
