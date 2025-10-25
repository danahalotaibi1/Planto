//
//  PlantRow.swift
//  Planto
//
//  Created by dana on 01/05/1447 AH.
//

import SwiftUI
struct PlantRow: View {
    let plant: Plant
    let isDoneToday: Bool
    var onToggle: () -> Void
    var onTap: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 6) {
                // أيقونة الغرفة من الـ Assets
                Image("room")
                    .renderingMode(.template)
                Text("in \(plant.room.rawValue)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            HStack(alignment: .top, spacing: 12) {
                Button(action: onToggle) {
                    Image(systemName: isDoneToday ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(isDoneToday ? Color("color3") : .secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Button(action: onTap) {
                        Text(plant.name)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    HStack(spacing: 8) {
                        // Light chip (sun - أصفر)
                        Chip(assetIcon: "sun",
                             text: plant.light.rawValue,
                             tintColor: Color("color5"))

                        // Water chip (water - أزرق)
                        Chip(assetIcon: "water",
                             text: plant.water.rawValue,
                             tintColor: Color("color6"))
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
        .onTapGesture { onTap() }
    }
}

private struct Chip: View {
    var assetIcon: String
    var text: String
    var tintColor: Color

    var body: some View {
        HStack(spacing: 6) {
            Image(assetIcon)
                .renderingMode(.template)
                .foregroundStyle(tintColor) // ← لون الأيقونة

            Text(text)
                .font(.caption)
                .foregroundStyle(tintColor) // ← لون النص نفسه
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color("color1")) // ← خلفية موحدة
                .overlay(Capsule().stroke(Color.white.opacity(0.08), lineWidth: 0.6))
        )
    }
}
