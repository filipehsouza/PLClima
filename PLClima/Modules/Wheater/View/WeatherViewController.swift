//
//  WeatherViewController.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var presenter: WeatherPresenterProtocol!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let router = WeatherRouter(presentingViewController: self)
        presenter = WeatherPresenter(router: router)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    @IBAction func changeCity(_ sender: UIButton) {
        presenter.showChangeCityScreen()
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location  = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = "\(location.coordinate.latitude)"
            let longitude = "\(location.coordinate.longitude)"
            presenter.showCurrentWeather(fromLat: latitude, andLong: longitude) { weather in
                DispatchQueue.main.async {
                    self.temperatureLabel.text = "\(weather.temperature)ºC"
                    self.weatherIcon.image = UIImage(named: weather.weatherIcon)
                    self.cityLabel.text = weather.city
                }
            }
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.cityLabel.text = "Tempo indisponível"
    }
}
