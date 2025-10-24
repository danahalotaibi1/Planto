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
                    Picker("Room", selection: $room) {
                        ForEach(Room.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .listRowBackground(Color("color2"))

                    Picker("Light", selection: $light) {
                        ForEach(LightLevel.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .listRowBackground(Color("color2"))
                }

                // MARK: Watering & Amount
                Section {
                    Picker("Watering Days", selection: $schedule) {
                        ForEach(WateringDays.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .listRowBackground(Color("color2"))

                    Picker("Water", selection: $water) {
                        ForEach(WaterAmount.allCases) { Text($0.rawValue).tag($0) }
                    }
                    .listRowBackground(Color("color2"))
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("color1"))

            // ✅✅ التولبار المصحّح (واحد فقط، غير متعشّش)
            .toolbar {
                // زر الإغلاق ❌ (color1) + Liquid Glass دائرة
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

                // العنوان بمنتصف التولبار
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                }

                // زر التأكيد ✅ (color3) + Liquid Glass دائرة
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
