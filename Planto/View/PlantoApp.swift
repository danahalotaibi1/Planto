//
//  PlantoApp.swift
//  Planto
//
//  Created by dana on 27/04/1447 AH.
//

import SwiftUI
import UserNotifications

@main
struct PlantoApp: App {
    @StateObject private var vm = PlantsViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // ← كما هو

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(vm)
                .task {
                    // اطلب الإذن ثم schedule
                    NotificationManager.shared.requestAuthorization { granted in
                        if granted {
                            // 1) اختبار سريع: بعد دقيقتين (مرة واحدة)
                            let testDate = Date().addingTimeInterval(120)
                            NotificationManager.shared.scheduleOneTime(at: testDate, id: "water-plant-once")

                            // 2) تنبيه يومي متكرر
                            NotificationManager.shared.scheduleDailyWaterReminder(hour: 17, minute: 18, id: "water-plant-daily")
                        } else {
                            print("Notifications not granted")
                        }
                    }
                }
        }
    }
}

