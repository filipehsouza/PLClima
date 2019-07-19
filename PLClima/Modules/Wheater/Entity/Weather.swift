//
//  Weather.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

// MARK: - Weather
import Foundation

struct Weather: Codable {
    let weather: [WeatherElement]
    let main: Main
    let name: String
    let cod: Int
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}
