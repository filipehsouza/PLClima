//
//  WeatherRouter.swift
//  PLClima
//
//  Created by FAP on 17/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherRouterProtocol {
    func showChangeCityScreen()
}

class WeatherRouter: WeatherRouterProtocol {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func showChangeCityScreen() {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let changeCityViewController = storyboard.instantiateViewController(withIdentifier: "ChangeCity")
        
        presentingViewController.present(changeCityViewController, animated: true, completion: nil)
    }
    
}
