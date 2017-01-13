//
//  NotificationViewController.swift
//  myContentExt
//
//  Created by Kimar Arakaki Neves on 2016-12-10.
//  Copyright © 2016 Kimar. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let image = imageData {
                imageView.image = UIImage(data: image)
            }
        }
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "fistBump" {
            completion(.dismissAndForwardAction)
        }
        
        if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }
}
