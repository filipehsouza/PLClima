//
//  WeatherPresenter.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation

protocol WeatherPresenterProtocol {
    func showCurrentWeather(fromLat lat: String, andLong long: String, _ completion: @escaping (_ weather: WeatherViewModel) -> Void)
    func showChangeCityScreen()
}

class WeatherPresenter: WeatherPresenterProtocol {
    let interactor: WeatherInteractorProtocol
    let router: WeatherRouterProtocol
    
    init(router: WeatherRouterProtocol) {
        interactor = WeatherInteractor()
        self.router = router
    }
    
    func showCurrentWeather(fromLat lat: String, andLong long: String, _ completion: @escaping (WeatherViewModel) -> Void) {
        interactor.getWeather(fromLat: lat, andLong: long) { (weather) in
            guard let weather = weather else {
                completion(self.createEmptyWeatherViewModel())
                return
            }
            
            completion(self.createWeatherViewModel(from: weather))
        }
    }
    
    func showChangeCityScreen() {
        router.showChangeCityScreen()
    }
    
    private func createEmptyWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(temperature: 0, condition: 9999, city: "Tempo indisponível")
    }
    
    private func createWeatherViewModel(from weather: Weather) -> WeatherViewModel {
        return WeatherViewModel(temperature: Int(weather.main.temp - 273.15),
                                condition: weather.weather[0].id,
                                city: weather.name)
    }
}
