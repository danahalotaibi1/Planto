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

                let allDone = !vm.plants.isEmpty && vm.doneCountToday == vm.plants.count

                VStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Plants 🌱")
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)

                        Divider()
                            .background(Color.primary.opacity(0.12))
                            .padding(.bottom, allDone ? 0 : 35)

                        if !allDone {
                            if vm.doneCountToday == 0 {
                                Text("Your plants are waiting for a sip 💦")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(.bottom, 12)
                            } else {
                                Text("\(vm.doneCountToday) of your plants feel loved today ✨")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }

                            ProgressView(value: animate ? vm.progressToday : 0)
                                .tint(Color("color3"))
                                .animation(.easeInOut(duration: 0.5), value: vm.progressToday)
                                .onAppear { animate = true }
                                .padding(.horizontal, 12)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 6)

                    if allDone {
                        Spacer(minLength: 20)
                        VStack(spacing: 16) {
                            Image("plant2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                                .shadow(radius: 8, y: 3)

                            Text("All Done! 🎉")
                                .font(.title.bold())
                                .foregroundColor(.primary)

                            Text("All Reminders Completed")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 24)
                        Spacer()
                    } else {
                        // -------- الفرز: غير منجزين أولاً ثم المُنجزين --------
                        let sorted = vm.plants.sorted { a, b in
                            let aDone = vm.isWateredToday(a)
                            let bDone = vm.isWateredToday(b)
                            if aDone == bDone { return true } // نفس المجموعة: اترك الترتيب كما هو تقريبًا
                            return !aDone && bDone           // غير المنجز قبل المنجز
                        }

                        List {
                            ForEach(sorted) { plant in
                                PlantRow(
                                    plant: plant,
                                    isDoneToday: vm.isWateredToday(plant),
                                    onToggle: { vm.toggleWatered(plant) },
                                    onTap:   { vm.editingPlant = plant }
                                )
                            }
                            // إصلاح الحذف بعد الفرز: نحول الإندكسات من القائمة المرتبة إلى الإندكسات في المصفوفة الأصلية
                            .onDelete { offsets in
                                let ids = offsets.map { sorted[$0].id }
                                let originalIdxs = ids.compactMap { id in
                                    vm.plants.firstIndex(where: { $0.id == id })
                                }
                                vm.delete(at: IndexSet(originalIdxs))
                            }
                        }
                        .listStyle(.plain)
                    }
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
                        shape: .circle(diameter: 59),
                        baseColor: Color("color3")
                    )
                )
                .padding(20)
            }
            .sheet(isPresented: Binding(
                get: { vm.showAddSheet || vm.editingPlant != nil },
                set: { if !$0 { vm.showAddSheet = false; vm.editingPlant = nil } }
            )) {
                AddEditDeletePlantSheet(editingPlant: vm.editingPlant)
                    .presentationDetents([.fraction(5.9)])
            }
            .background(Color(.systemBackground))
        }
    }
}

