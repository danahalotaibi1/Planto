//
//  PlantModels.swift
//  Planto
//
//  Created by dana on 30/04/1447 AH.
//

import Foundation

enum Room: String, CaseIterable, Identifiable, Codable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
    var id: String { rawValue }
}

enum LightLevel: String, CaseIterable, Identifiable, Codable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"
    var id: String { rawValue }
}

enum WateringDays: String, CaseIterable, Identifiable, Codable {
    case everyDay = "Every day"
    case every2 = "Every 2 days"
    case every3 = "Every 3 days"
    case onceWeek = "Once a week"
    case every10 = "Every 10 days"
    case every2Weeks = "Every 2 weeks"
    var id: String { rawValue }
}

enum WaterAmount: String, CaseIterable, Identifiable, Codable {
    case ml20_50  = "20–50 ml"
    case ml50_100 = "50–100 ml"
    case ml100_200 = "100–200 ml"
    case ml200_300 = "200–300 ml"
    var id: String { rawValue }
}

struct Plant: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var room: Room
    var light: LightLevel
    var schedule: WateringDays
    var water: WaterAmount
    var createdAt: Date
    var lastWateredAt: Date? = nil

    init(
        id: UUID = UUID(),
        name: String,
        room: Room,
        light: LightLevel,
        schedule: WateringDays,
        water: WaterAmount,
        createdAt: Date = .now,
        lastWateredAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.room = room
        self.light = light
        self.schedule = schedule
        self.water = water
        self.createdAt = createdAt
        self.lastWateredAt = lastWateredAt
    }
}
