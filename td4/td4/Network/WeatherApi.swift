//
//  WeatherView.swift
//  td4
//
//  Created by SOUCHET Julie on 18/05/2022.
//

import Foundation

class WeatherApi {
  var city: String = "Nanterre" // TODO geolocalisation

  func loadWeather(completion: @escaping (WeatherModel?) -> ()) {
    let apiURL = "https://api.weatherapi.com/v1/current.json?key=e4a0813d09de4ffa84594528221805&q=\(city)&aqi=no"

    guard let url = URL(string: apiURL) else {
      print("invalid url: \(apiURL)")
      completion(nil)
      return
    }

    Networker<WeatherResult>.fetch(url) { result in
      let weatherModel: WeatherModel = WeatherModel(
        name: result.location.name,
        region: result.location.region,
        country: result.location.country,
        temp_c: result.current.temp_c.description,
        text: result.current.condition.text,
        icon: result.current.condition.icon,
        wind_kph: result.current.wind_kph.description,
        wind_degree: result.current.wind_degree.description,
        wind_dir: result.current.wind_dir
      )
      completion(weatherModel)
    }
  }
}
