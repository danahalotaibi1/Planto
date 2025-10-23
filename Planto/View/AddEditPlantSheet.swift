//
//  AddEditPlantSheet.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.
//
import SwiftUI

struct AddEditPlantSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: PlantsViewModel

    // لو جاي تعديل، مرري plant موجودة
    var editingPlant: Plant?

    @State private var name: String = ""
    @State private var room: Room = .bedroom
    @State private var light: LightLevel = .fullSun
    @State private var schedule: WateringDays = .everyDay
    @State private var water: WaterAmount = .ml20_50

    init(editingPlant: Plant? = nil) {
        self.editingPlant = editingPlant
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Plant Name | Pothos", text: $name)
                        .textInputAutocapitalization(.words)
                        .submitLabel(.done)
                        .padding(8)
                        .background(Color.white.opacity(0.06), in: RoundedRectangle(cornerRadius: 16))

                } header: {
                    Text("Set Reminder").font(.headline)
                }

                Section {
                    Picker("Room", selection: $room) {
                        ForEach(Room.allCases) { Text($0.rawValue).tag($0) }
                    }
                    Picker("Light", selection: $light) {
                        ForEach(LightLevel.allCases) { Text($0.rawValue).tag($0) }
                    }
                }

                Section {
                    Picker("Watering Days", selection: $schedule) {
                        ForEach(WateringDays.allCases) { Text($0.rawValue).tag($0) }
                    }
                    Picker("Water", selection: $water) {
                        ForEach(WaterAmount.allCases) { Text($0.rawValue).tag($0) }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.black.opacity(0.98))
            .navigationTitle("Set Reminder")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
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
                        Image(systemName: "checkmark.circle.fill")
                    }
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
