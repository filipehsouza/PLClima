//
//  WeatherApiService.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation
import PLNetwork

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request is outdated"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}

struct WeatherApiService {
    private let router = Router<WeatherApi>()
    
    func getWeather(fromLat lat: String, andLong long: String, completion: @escaping (_ weather: Weather?, _ error:String?) -> ()) {
        router.request(.weather(lat: lat, long: long)) { (data, response, error) in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
    }
    
    func getWeather(fromCity city: String, completion: @escaping (_ weather: Weather?, _ error:String?) -> ()) {
        router.request(.weatherFrom(City: city)) { (data, response, error) in
            self.handleResponse(data: data, response: response, error: error, completion: completion)
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    fileprivate func handleResponse(data: Data?, response:URLResponse?, error:Error?, completion: @escaping (_ weather: Weather?, _ error:String?) -> ()) {
        if error != nil {
            completion(nil, "Please check your network connection")
        }
        if let response = response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(nil, NetworkResponse.noData.rawValue)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(Weather.self, from: responseData)
                    completion(apiResponse, nil)
                } catch {
                    completion(nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                completion(nil, networkFailureError)
            }
        }
    }
}
