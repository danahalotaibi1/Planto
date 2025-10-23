//
//  PlantoApp.swift
//  Planto
//
//  Created by dana on 27/04/1447 AH.
//

import SwiftUI   

@main
struct PlantoApp: App {
    @StateObject private var vm = PlantsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
