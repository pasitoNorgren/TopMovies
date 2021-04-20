//
//  NotificationSettings.swift
//  TopMovies1
//
//  Created by Матвей Бойков on 19.04.2021.
//

import UIKit
import UserNotifications

class NotificationSettings  {
    
    private let center = UNUserNotificationCenter.current()
    
    internal func registerLocal() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                self.center.requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    internal func scheduleLocal(date : Date, filmName : String) {
        
        let calendar = Calendar.current
        
        let content = UNMutableNotificationContent()
        content.title = Constants.Notification.notificationTitle
        content.body = filmName + " " + Constants.Notification.notificationBodyPart
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.hour = calendar.component(.hour, from: date)
        dateComponents.minute = calendar.component(.minute, from: date)
        dateComponents.second = calendar.component(.second, from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
}


