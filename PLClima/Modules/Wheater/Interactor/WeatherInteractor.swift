//
//  WeatherInteractor.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import CoreLocation

protocol WeatherInteractorProtocol {
    func getWeather(fromLat lat: String, andLong long: String, _ completion: @escaping (_ weather: Weather?) -> Void)
}

class WeatherInteractor: WeatherInteractorProtocol {
    let apiService: WeatherApiService
    
    init() {
        apiService = WeatherApiService()
    }
    
    func getWeather(fromLat lat: String, andLong long: String, _ completion: @escaping (Weather?) -> Void) {
        self.apiService.getWeather(fromLat: lat, andLong: long) { (weather, error) in
            guard let _ = weather else {
                completion(nil)
                return
            }
            completion(weather)
        }
    }
    
}
