//
//  WeatherData.swift
//  openweathermap
//
//  Created by Constantine Likhachov on 23.12.2020.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

