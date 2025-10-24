//
//  LiquidGlassButtonStyle.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.
//
import SwiftUI

/// زر زجاجي سائل يدعم شكلين: مستطيل (pill) أو دائرة (circle)
struct LiquidGlassButtonStyle: ButtonStyle {

    enum Shape {
        case pill(cornerRadius: CGFloat = 26)      // للزر العريض مثل "Set Plant Reminder"
        case circle(diameter: CGFloat = 36)        // لأزرار الأيقونات (✅/❌)
    }

    private let shape: Shape
    private let baseColor: Color

    /// - Parameters:
    ///   - shape: نوع الشكل (pill أو circle)
    ///   - baseColor: اللون الأساسي للزر (مثلاً Color("color3") أو Color("color1"))
    init(shape: Shape = .pill(), baseColor: Color = Color("color3")) {
        self.shape = shape
        self.baseColor = baseColor
    }

    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed

        switch shape {

        // MARK: - زر مستطيل عريض (Pill)
        case .pill(let r):
            return AnyView(
                configuration.label
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: r, style: .continuous)
                                .fill(baseColor)
                                .brightness(pressed ? -0.06 : 0)

                            RoundedRectangle(cornerRadius: r, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.white.opacity(pressed ? 0.10 : 0.14), .clear],
                                        startPoint: .topLeading, endPoint: .bottomTrailing
                                    )
                                )
                                .padding(2)

                            RoundedRectangle(cornerRadius: r, style: .continuous)
                                .stroke(Color.white.opacity(0.22), lineWidth: 6)
                        }
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: r, style: .continuous)
                            .stroke(baseColor.opacity(0.95), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.35), radius: pressed ? 8 : 14, x: 0, y: pressed ? 3 : 6)
                    .scaleEffect(pressed ? 0.98 : 1.0)
                    .animation(.easeOut(duration: 0.12), value: pressed)
            )

        // MARK: - زر دائري للأيقونات (Circle)
        case .circle(let d):
            return AnyView(
                configuration.label
                    .foregroundStyle(.white)
                    .frame(width: d, height: d)
                    .background(
                        ZStack {
                            Circle()
                                .fill(baseColor)
                                .brightness(pressed ? -0.06 : 0)

                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color.white.opacity(pressed ? 0.12 : 0.18), .clear],
                                        startPoint: .topLeading, endPoint: .bottomTrailing
                                    )
                                )
                                .padding(2)

                            Circle()
                                .stroke(Color.white.opacity(0.25), lineWidth: 1)
                        }
                    )
                    .overlay(
                        Circle().stroke(baseColor.opacity(0.9), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.35), radius: pressed ? 8 : 12, x: 0, y: pressed ? 3 : 6)
                    .scaleEffect(pressed ? 0.95 : 1.0)
                    .animation(.easeOut(duration: 0.12), value: pressed)
            )
        }
    }
}
