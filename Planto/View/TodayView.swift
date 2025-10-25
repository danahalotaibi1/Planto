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
                        Divider()
                            .background(Color.primary.opacity(0.12))
                            .padding(.bottom, 35) // ← مسافة بسيطة بعد الخط

                        if vm.doneCountToday == 0 {
                            Text("Your plants are waiting for a sip 💦")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.bottom, 12) // ← مسافة بين النص والـ ProgressView
                        } else {
                            Text("\(vm.doneCountToday) of your plants feel loved today ✨")
                                .foregroundStyle(.secondary)
                        }

                        ProgressView(value: animate ? vm.progressToday : 0)
                            .tint(Color("color3"))
                            .animation(.easeInOut(duration: 0.5), value: vm.progressToday)
                            .onAppear { animate = true }
                            .padding(.horizontal, 12) // ← تقلّص العرض من اليمين واليسار
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

                Button {
                    vm.editingPlant = nil
                    vm.showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.white)
                }
                .buttonStyle(
                    LiquidGlassButtonStyle(
                        shape: .circle(diameter: 59),     // حجم الزر الدائري (غيّريه 52–64 حسب ذوقك)
                        baseColor: Color("color3")        // أخضر من الأصول
                    )
                )
                .padding(20)
                }
              
            }
            .sheet(isPresented: Binding(
                get: { vm.showAddSheet || vm.editingPlant != nil },
                set: { if !$0 { vm.showAddSheet = false; vm.editingPlant = nil } }
            )) {
                AddEditPlantSheet(editingPlant: vm.editingPlant)
                    .presentationDetents([.fraction(5.9)])
            }
            .background(Color(.systemBackground))
        }
    }

