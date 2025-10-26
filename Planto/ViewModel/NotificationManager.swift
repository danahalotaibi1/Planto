//
//  NotificationManager..swift
//  Planto
//
//  Created by dana on 04/05/1447 AH.
//

import Foundation
import UserNotifications
import SwiftUI
import Combine

final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    private init() {}

    // طلب الإذن
    func requestAuthorization(completion: ((Bool) -> Void)? = nil) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            // اختياري: اطبعي الحالة للمراجعة في الكونسول
            if granted { print("✅ Notifications allowed") } else { print("🚫 Notifications not allowed") }
            DispatchQueue.main.async { completion?(granted) }
        }
    }

    // تنبيه يومي
    func scheduleDailyWaterReminder(hour: Int = 17, minute: Int = 18, id: String = "water-plant-daily") {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body  = "Hey! let’s water your plant"
        content.sound = .default

        var comps = DateComponents()
        comps.hour = hour
        comps.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    // مرة واحدة
    func scheduleOneTime(at date: Date, id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])

        let content = UNMutableNotificationContent()
        content.title = "Planto"
        content.body  = "Hey! let’s water your plant"
        content.sound = .default

        let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)

        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func cancelAll() { UNUserNotificationCenter.current().removeAllPendingNotificationRequests() }
    func cancel(id: String) { UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id]) }
}
