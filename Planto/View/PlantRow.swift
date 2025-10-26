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
                Image("room")
                    .renderingMode(.template)
                Text("in \(plant.room.rawValue)")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            HStack(alignment: .top, spacing: 12) {

                // زر التشييك
                Button(action: onToggle) {
                    if isDoneToday {
                        ZStack {
                            Circle().fill(Color("color3"))
                            Image(systemName: "checkmark")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(.black.opacity(0.75))
                        }
                        .frame(width: 26, height: 26)
                        .overlay(Circle().stroke(Color("color3").opacity(0.65), lineWidth: 1))
                        .shadow(color: Color("color3").opacity(0.25), radius: 3, y: 1)
                    } else {
                        Circle()
                            .strokeBorder(Color.secondary.opacity(0.6), lineWidth: 2)
                            .frame(width: 26, height: 26)
                    }
                }
                .buttonStyle(.plain)        // ← يمنع تأثيرات أزرار القائمة
                .contentShape(Circle())

                VStack(alignment: .leading, spacing: 8) {
                    Button(action: onTap) {
                        Text(plant.name)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(isDoneToday ? .secondary : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    HStack(spacing: 8) {
                        Chip(assetIcon: "sun",
                             text: plant.light.rawValue,
                             tintColor: Color("color5"))
                        Chip(assetIcon: "water",
                             text: plant.water.rawValue,
                             tintColor: Color("color6"))
                    }
                }
            }
        }
        .padding(.vertical, 6)
        .shadow(color: isDoneToday ? Color("color3").opacity(0.22) : .clear,
                radius: isDoneToday ? 8 : 0, x: 0, y: 0)
        .contentShape(Rectangle())
        .onTapGesture { onTap() }   // ← الضغط على أي مكان بالصف يفتح شاشة التعديل
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
                .foregroundStyle(tintColor)

            Text(text)
                .font(.caption)
                .foregroundStyle(tintColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color("color1"))
                .overlay(Capsule().stroke(Color.white.opacity(0.08), lineWidth: 0.6))
        )
    }
}
