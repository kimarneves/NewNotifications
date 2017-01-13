//
//  ViewController.swift
//  NewNotifications
//
//  Created by Kimar Arakaki Neves on 2016-12-10.
//  Copyright © 2016 Kimar. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request permission from user to use Notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription ??  "Failed to receive permission")
            }
        })
    }

    @IBAction func notifyButtonTapped(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Sucessfully scheduled notification")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notify = UNMutableNotificationContent()
        
        // To use custom notifcation
        notify.categoryIdentifier = "myNotificationCategory"
        
        notify.title = "New Notifcation"
        notify.subtitle = "Notification Subtitle"
        notify.body = "The new notification options in iOS10 works"
        
        //Add an attachment
        guard let imageUrl = Bundle.main.url(forResource: "rick_grimes", withExtension: "gif") else {
            completion(false)
            return
        }
        let myAttachment: UNNotificationAttachment
        myAttachment = try! UNNotificationAttachment(identifier: "customNotification", url: imageUrl, options: .none)
        notify.attachments = [myAttachment]
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "customNotification", content: notify, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

