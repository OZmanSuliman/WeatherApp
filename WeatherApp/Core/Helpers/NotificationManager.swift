//
//  NotificationManager.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 07/09/2022.
//

import Foundation
import UserNotifications

class LocalNotificationManager {
    func switchNotification(title: String, subtitle: String) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                let content = UNMutableNotificationContent()
                content.title = title
                content.subtitle = subtitle
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
