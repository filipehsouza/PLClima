//
//  ChangeCityPresenter.swift
//  PLClima
//
//  Created by FAP on 19/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation

protocol ChangeCityPresenterProtocol {
    func getWeatherFrom(city: String)
    func goBack()
}

class ChangeCityPresenter: ChangeCityPresenterProtocol {
   
    let router:ChangeCityRouterProtocol
    let completion: (String) -> Void
    
    init(router: ChangeCityRouterProtocol, _ completion: @escaping (String) -> Void) {
        self.router = router
        self.completion = completion
    }
    
    func getWeatherFrom(city: String) {
        router.goBack()
        completion(city)
    }
    
    func goBack() {
        router.goBack()
    }

}
