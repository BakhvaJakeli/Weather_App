//
//  DailyWeatherModel.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 28.08.21.
//


import Foundation

// MARK: - Welcome
struct DailyWeatherModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [DailyList]
    let city: DailyCity
}

// MARK: - City
struct DailyCity: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct DailyCoord: Codable {
    let lat, lon: Int
}

// MARK: - List
struct DailyList: Codable {
    let dt: Int
    let main: DailyMainClass
    let weather: [WeatherModel]
    let clouds: DailyClouds
    let wind: DailyWind
    let visibility: Int
    let pop: Double
    let rain: DailyRain?
    let sys: DailySys
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain, sys
        case dtTxt = "dt_txt"
    }
}

// MARK: - Clouds
struct DailyClouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct DailyMainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct DailyRain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct DailySys: Codable {
    let pod: DailyPod
}

enum DailyPod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct WeatherModel: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

// MARK: - Wind
struct DailyWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
