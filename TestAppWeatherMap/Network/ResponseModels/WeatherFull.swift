//
//  Wether.swift
//  TestAppWeatherMap
//
//  Created by pioner on 18.02.2021.
//

import Foundation

struct WeatherFull: Codable {
    
    var name: String?
    var coord: Coord?
    var main: Main?
    var weather: [Weather]?
    var wind: Wind?
}

struct Coord: Codable {
    var lon: Float?
    var lat: Float?
}

struct Main: Codable {
    var temp: Float?
    var pressure: Int?
    var humidity: Int?
}

struct Weather: Codable {
    var main: String?
    var description:String?
    var icon: String?
}

struct Wind: Codable {
    var speed: Float?
    var deg: Float?
}
