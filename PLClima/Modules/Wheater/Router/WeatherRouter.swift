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
    func showChangeCityScreen(_ completion: @escaping (String) -> Void)
}

class WeatherRouter: WeatherRouterProtocol {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func showChangeCityScreen(_ completion: @escaping (String) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let changeCityViewController = storyboard.instantiateViewController(withIdentifier: "ChangeCity")
        guard let viewController = changeCityViewController as? ChangeCityViewController else {
            fatalError("ViewController is not from ChangeCityViewController class")
        }
        viewController.completion = completion
        presentingViewController.present(changeCityViewController, animated: true, completion: nil)
    }
    
}
