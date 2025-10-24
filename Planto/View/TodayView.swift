//
//  TodayView.swift
//  Planto
//
//  Created by dana on 01/05/1447 AH.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject private var vm: PlantsViewModel
    @State private var animate = false

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Plants 🌱")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                        Divider().background(Color.primary.opacity(0.12))

                        if vm.doneCountToday == 0 {
                            Text("Your plants are waiting for a sip 💦").foregroundStyle(.secondary)
                        } else {
                            Text("\(vm.doneCountToday) of your plants feel loved today ✨")
                                .foregroundStyle(.secondary)
                        }

                        ProgressView(value: animate ? vm.progressToday : 0)
                            .tint(Color("color3")) // أخضر موحد
                            .animation(.easeInOut(duration: 0.5), value: vm.progressToday)
                            .onAppear { animate = true }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 6)

                    List {
                        ForEach(vm.plants) { plant in
                            PlantRow(
                                plant: plant,
                                isDoneToday: vm.isWateredToday(plant),
                                onToggle: { vm.toggleWatered(plant) },
                                onTap:   { vm.editingPlant = plant }
                            )
                        }
                        .onDelete(perform: vm.delete)
                    }
                    .listStyle(.plain)
                }

                // زر + بزجاج سائل (يشتغل على الدارك/اللايت)
                Button {
                    vm.editingPlant = nil
                    vm.showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .padding(18)
                        .foregroundStyle(.white)
                }
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .overlay(Circle().stroke(Color.primary.opacity(0.25), lineWidth: 1))
                        .shadow(color: .black.opacity(0.25), radius: 12, y: 6)
                        .overlay(
                            Circle().fill(
                                LinearGradient(colors: [.white.opacity(0.18), .clear],
                                               startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                        )
                        .overlay(Circle().stroke(Color("color3").opacity(0.6), lineWidth: 1))
                )
                .tint(Color("color3"))
                .padding(20)
            }
            .sheet(isPresented: Binding(
                get: { vm.showAddSheet || vm.editingPlant != nil },
                set: { if !$0 { vm.showAddSheet = false; vm.editingPlant = nil } }
            )) {
                AddEditPlantSheet(editingPlant: vm.editingPlant)
                    .presentationDetents([.fraction(5.9)])   // ← تغطي 90%
            }
            .background(Color(.systemBackground)) // ← متكيّف
        }
    }
}
