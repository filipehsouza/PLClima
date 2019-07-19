//
//  WeatherApi.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation
import PLNetwork

let WEATHER_URL = "http://api.openweathermap.org/data/2.5"
let APP_ID = "51ff7e8934867388923c5ab8f7ea5fb6"

public enum WeatherApi {
    case weather(lat:String, long: String)
}

extension WeatherApi: EndpointType {
    public var baseURL: URL {
        guard let url = URL(string: WEATHER_URL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        return "/weather"
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        switch self {
        case .weather(let lat, let long):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["lat" : lat, "lon" : long, "appid" : APP_ID])
        }
    }
    
    public var headers: HTTPHeaders? {
        return nil
    }
    
    
}
