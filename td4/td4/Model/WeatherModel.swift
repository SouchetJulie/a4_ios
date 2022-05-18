//
//  WeatherModel.swift
//  td4
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation

struct WeatherModel: Codable {
  let name: String
  let region: String
  let country: String
  let temp_c: String
  let text: String
  let icon: String
  let wind_kph: String
  let wind_degree: String
  let wind_dir: String
}

struct WeatherResult: Codable {
  let location: Location
  let current: WeatherData
}

struct Location: Codable {
  let name: String
  let region: String
  let country: String
  let lat: Float
  let lon: Float
  let tz_id: String
  let localtime_epoch: Int
  let localtime: String
}

struct WeatherData: Codable {
  let last_updated_epoch: Int
  let last_updated: String
  let temp_c: Float
  let temp_f: Float
  let is_day: Int
  let condition: ConditionDescription
  let wind_mph: Float
  let wind_kph: Float
  let wind_degree: Int
  let wind_dir: String
  let pressure_mb: Float
  let pressure_in: Float
  let precip_mm: Float
  let precip_in: Float
  let humidity: Int
  let cloud: Int
  let feelslike_c: Float
  let feelslike_f: Float
  let vis_km: Float
  let vis_miles: Float
  let uv: Float
  let gust_mph: Float
  let gust_kph: Float
}

struct ConditionDescription: Codable {
  let text: String
  let icon: String
  let code: Int
}
