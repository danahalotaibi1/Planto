//
//  StartView.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.

import SwiftUI

struct StartView: View {
    @EnvironmentObject private var vm: PlantsViewModel
    @State private var showReminder = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // عنوان أبيض
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Plants 🌱")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)                           // <- أبيض
                    Divider().background(Color.white.opacity(0.12))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 4)

                Spacer()

                Image("plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .shadow(radius: 8, y: 3)

                VStack(spacing: 8) {
                    // العنوان الثاني أبيض
                    Text("Start your plant journey!")
                        .font(.title3.bold())
                        .foregroundColor(.white)                           // <- أبيض

                    // الفقرة بلون color4
                    Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("color4"))                  // <- color4
                        .padding(.horizontal, 20)
                }

                Button { showReminder = true } label: {
                    Text("Set Plant Reminder")
                        .foregroundColor(.white)     // نص أبيض
                }
               
                .buttonStyle(LiquidGlassButtonStyle())                    // ستايل الزجاج
                .tint(Color("color3"))                                    // يمرّر اللون للأثر
                .padding(.horizontal, 24)

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showReminder) {
                AddEditPlantSheet()
                    .presentationDetents([.medium, .large])
            }
            .toolbar(.hidden, for: .navigationBar)
            .background(Color.black.opacity(0.98))
        }
    }
}
