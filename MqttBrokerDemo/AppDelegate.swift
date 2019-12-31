//
//  AppDelegate.swift
//  MqttBrokerDemo
//
//  Created by Cevat BALABAN on 12/30/19.
//  Copyright © 2019 Cevat BALABAN. All rights reserved.
//

import UIKit
import Moscapsule

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var mqttClient: MQTTClient?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Mqtt.StartMQTT()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func StartMQTT() -> Void {
//
//        moscapsule_init()
//
//        //set MQTT client configuration
//        let RandomId : String = "IOS_\(UIDevice.current.identifierForVendor!.uuidString)"
//        let mqttConfig = MQTTConfig(clientId: RandomId, host: "test.mosquitto.org", port: 1883, keepAlive: Int32.max)
//
//
//
//        // Receive published message here
//        mqttConfig.onMessageCallback = { mqttMessage in
//
//            let receivedMessage = mqttMessage.payloadString!
//            let receivedTopic = mqttMessage.topic
//
//            print("Topic : \(receivedTopic)")
//            print("Topic : \(receivedMessage)")
//
////            self.DoBroadCast(Topic: receivedTopic, Message: receivedMessage)
//        }
//
//
//        mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: true)
//
//        mqttClient?.subscribe("cevat/test", qos: 0)
//
//        mqttClient?.publish(string: "online test", topic: "cevat/test", qos: 0, retain: false)
//
//
//    }
}

