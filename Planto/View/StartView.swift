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
                // العنوان (يتبع ألوان النظام)
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Plants 🌱")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                    Divider().background(Color.primary.opacity(0.12))
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
                    Text("Start your plant journey!")
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    // يبقى بلون color4 مثل ما تبين، ويتكيّف مع الخلفية
                    Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("color4"))
                        .padding(.horizontal, 20)
                }

                // زر Liquid Glass أخضر color3
                Button { showReminder = true } label: {
                    Text("Set Plant Reminder")
                        .foregroundColor(.white)
                }
                .buttonStyle(LiquidGlassButtonStyle())
                .padding(.horizontal, 24)

                Spacer(minLength: 40)
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showReminder) {
                AddEditPlantSheet()
                    .presentationDetents([.fraction(5.9)])
            }
            .toolbar(.hidden, for: .navigationBar)
            .background(Color(.systemBackground)) // ← متكيّف مع النظام
        }
    }
}
