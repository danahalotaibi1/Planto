//
//  LiquidGlassButtonStyle.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.
//
import SwiftUI


struct LiquidGlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed

        return configuration.label
            .font(.headline)
            .foregroundColor(.white) // نص أبيض
            .padding(.vertical, 14)
            .padding(.horizontal, 22)
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                    // الطبقة الأساسية: أخضر صريح من color3
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(Color("color3"))
                        .brightness(pressed ? -0.06 : 0) // تغميق بسيط عند الضغط

                    // لمعة سائلة مائلة (هايلايت)
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(pressed ? 0.06 : 0.14), .clear],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .padding(2)

                    // طبقة لمعان خفيفة من الداخل (يشبه الزجاج)
                    RoundedRectangle(cornerRadius: 26, style: .continuous)
                        .stroke(Color.white.opacity(0.22), lineWidth: 1)
                }
            )
            // حدود بنفس الأخضر لإحساس زجاجي
            .overlay(
                RoundedRectangle(cornerRadius: 26, style: .continuous)
                    .stroke(Color("color3").opacity(200), lineWidth: 10)
            )
            .shadow(color: .black.opacity(0.35), radius: pressed ? 8 : 14, x: 0, y: pressed ? 3 : 6)
            .scaleEffect(pressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: pressed)
    }
}
