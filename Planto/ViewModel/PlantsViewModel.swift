//
//  PlantsViewModel.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.
//
import Foundation
import Combine
import SwiftUI

final class PlantsViewModel: ObservableObject {
    @Published private(set) var plants: [Plant] = []
    @Published var showAddSheet = false
    @Published var editingPlant: Plant? = nil   // لفتح الشيت للتعديل من الصف

    private let storeKey = "planto.plants"

    init() { load() }

    // MARK: - Today state
    func isWateredToday(_ p: Plant) -> Bool {
        guard let d = p.lastWateredAt else { return false }
        return Calendar.current.isDateInToday(d)
    }

    func toggleWatered(_ p: Plant) {
        guard let i = plants.firstIndex(where: { $0.id == p.id }) else { return }
        if isWateredToday(plants[i]) {
            // إلغاء تشيك اليوم
            plants[i].lastWateredAt = nil
        } else {
            // تشيك اليوم الآن
            plants[i].lastWateredAt = Date()
        }
        save()
    }

    var doneCountToday: Int {
        plants.filter { isWateredToday($0) }.count
    }

    var progressToday: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(doneCountToday) / Double(plants.count)
    }

    // MARK: - CRUD
    func add(_ plant: Plant) {
        plants.insert(plant, at: 0)
        save()
    }

    func update(_ plant: Plant) {
        guard let i = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[i] = plant
        save()
    }

    func delete(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
        save()
    }

    // MARK: - Persistence
    private func save() {
        if let data = try? JSONEncoder().encode(plants) {
            UserDefaults.standard.set(data, forKey: storeKey)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storeKey),
              let decoded = try? JSONDecoder().decode([Plant].self, from: data) else { return }
        plants = decoded
    }
}
