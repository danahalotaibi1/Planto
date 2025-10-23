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
                Image(systemName: "location.north.circle")
                Text("in \(plant.room.rawValue)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            HStack(alignment: .top, spacing: 12) {
                Button(action: onToggle) {
                    Image(systemName: isDoneToday ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                        .foregroundStyle(isDoneToday ? Color("color1") : .secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Button(action: onTap) {
                        Text(plant.name)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack(spacing: 8) {
                        Chip(icon: "sun.max",  text: plant.light.rawValue)
                        Chip(icon: "drop.fill", text: plant.water.rawValue)
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
    var icon: String
    var text: String
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon).font(.caption2)
            Text(text).font(.caption)
        }
        .padding(.horizontal, 8).padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.white.opacity(0.06))
                .overlay(Capsule().stroke(Color.white.opacity(0.18), lineWidth: 1))
                .overlay(Capsule().stroke(Color("color1").opacity(0.45), lineWidth: 0.8))
        )
    }
}
