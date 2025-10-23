//
//  ContentView.swift
//  Planto
//
//  Created by dana on 27/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var vm: PlantsViewModel

    var body: some View {
        Group {
            if vm.plants.isEmpty {
                StartView()     // شاشة البداية
            } else {
                TodayView()     // شاشة اليوم
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(PlantsViewModel())
}
