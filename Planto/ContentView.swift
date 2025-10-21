//
//  ContentView.swift
//  Planto
//
//  Created by dana on 27/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    // Header
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .lastTextBaseline, spacing: 8) {
                            Text("My Plants")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(.white)

                            Text("🌱")
                                .font(.system(size: 28))
                                .accessibilityHidden(true)
                        }

                        Divider()
                            .background(Color.white.opacity(0.15))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    // Content
                    VStack(spacing: 24) {
                        // Plant image
                        Image("plant")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 320)
                            .padding(.top, 40)
                            .accessibilityLabel("Cute plant pot")

                        // Title
                        Text("Start your plant journey!")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)

                        // Subtitle
                        Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 28)

                        // Button
                        Button(action: {
                            
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                        }
                        .background(
                            LinearGradient(
                                colors: [Color(red: 0.0, green: 0.78, blue: 0.55),
                                         Color(red: 0.0, green: 0.63, blue: 0.45)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                        Spacer(minLength: 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    ContentView()
}
