//
//  AppDelegate.swift
//  Planto
//
//  Created by dana on 04/05/1447 AH.
//

import UIKit
import UserNotifications
// ✅ AppDelegate مسؤول عن عرض البانر والصوت حتى مع فتح التطبيق
final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // ضروري: نعيّن الديليجيت بدري
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // يخلي الإشعار يظهر كبانر/صوت/بادج إذا الأب Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}
