//
//  AddEditDeletePlantSheet.swift
//  Planto
//
//  Created by dana on 04/05/1447 AH.
//

import SwiftUI

struct AddEditDeletePlantSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: PlantsViewModel

    var editingPlant: Plant?

    @State private var name: String = ""
    @State private var room: Room = .bedroom
    @State private var light: LightLevel = .fullSun
    @State private var schedule: WateringDays = .everyDay
    @State private var water: WaterAmount = .ml20_50
    @State private var showDeleteConfirm = false

    init(editingPlant: Plant? = nil) {
        self.editingPlant = editingPlant
    }

    var body: some View {
        NavigationStack {
            Form {
                // MARK: Name
                Section {
                    HStack {
                        ZStack(alignment: .leading) {
                            if name.isEmpty {
                                HStack(spacing: 0) {
                                    Text("Plant Name").foregroundColor(.white)
                                    Text("  Pothos").foregroundColor(Color.gray.opacity(0.6))
                                }
                                .padding(.horizontal, 16)
                            }

                            TextField("", text: $name)
                                .foregroundColor(.white)
                                .textInputAutocapitalization(.words)
                                .submitLabel(.done)
                                .padding(.vertical, 16)
                                .padding(.horizontal, 16)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color("color2"), in: RoundedRectangle(cornerRadius: 24))
                    }
                }
                .listRowInsets(EdgeInsets(top: 6, leading: 5, bottom: 6, trailing: 5))
                .listRowBackground(Color.clear)

                // MARK: Room & Light
                Section {
                    HStack {
                        Image("room")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Picker("Room", selection: $room) {
                            ForEach(Room.allCases) { Text($0.rawValue).tag($0) }
                        }
                    }
                    .listRowBackground(Color("color2"))

                    HStack {
                        Image("sun")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Picker("Light", selection: $light) {
                            ForEach(LightLevel.allCases) { Text($0.rawValue).tag($0) }
                        }
                    }
                    .listRowBackground(Color("color2"))
                }

                // MARK: Watering & Amount
                Section {
                    HStack {
                        Image("water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Picker("Watering Days", selection: $schedule) {
                            ForEach(WateringDays.allCases) { Text($0.rawValue).tag($0) }
                        }
                    }
                    .listRowBackground(Color("color2"))

                    HStack {
                        Image("water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Picker("Water", selection: $water) {
                            ForEach(WaterAmount.allCases) { Text($0.rawValue).tag($0) }
                        }
                    }
                    .listRowBackground(Color("color2"))
                }

                // ====== Delete Button مباشرة بعد Water ======
                if editingPlant != nil {
                    Section {
                        Button(role: .destructive) {
                            showDeleteConfirm = true
                        } label: {
                            Text("Delete Reminder")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .foregroundColor(.red)
                                .background(
                                    RoundedRectangle(cornerRadius: 26)
                                        .fill(Color("color2"))
                                )
                        }
                        .confirmationDialog(
                            "Delete this reminder?",
                            isPresented: $showDeleteConfirm,
                            titleVisibility: .visible
                        ) {
                            Button("Delete", role: .destructive) {
                                if let p = editingPlant,
                                   let idx = vm.plants.firstIndex(where: { $0.id == p.id }) {
                                    vm.delete(at: IndexSet(integer: idx))
                                    dismiss()
                                }
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 6, leading: 22, bottom: 6, trailing: 22))
                    .listRowBackground(Color.clear)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("color1"))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .buttonStyle(
                        LiquidGlassButtonStyle(
                            shape: .circle(diameter: 36),
                            baseColor: Color("color1")
                        )
                    )
                }

                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        guard !trimmed.isEmpty else { return }

                        let plant = Plant(
                            id: editingPlant?.id ?? UUID(),
                            name: trimmed,
                            room: room, light: light,
                            schedule: schedule, water: water
                        )
                        if editingPlant == nil { vm.add(plant) } else { vm.update(plant) }
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .buttonStyle(
                        LiquidGlassButtonStyle(
                            shape: .circle(diameter: 36),
                            baseColor: Color("color3")
                        )
                    )
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
        .onAppear {
            if let p = editingPlant {
                name = p.name
                room = p.room
                light = p.light
                schedule = p.schedule
                water = p.water
            }
        }
    }
}
