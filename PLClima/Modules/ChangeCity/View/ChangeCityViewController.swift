//
//  ChangeCityViewController.swift
//  PLClima
//
//  Created by FAP on 19/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import UIKit

class ChangeCityViewController: UIViewController {
    
    @IBOutlet weak var cityTextField: UITextField!
    
    var presenter: ChangeCityPresenterProtocol!
    var completion: ((String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let router = ChangeCityRouter(presentingViewController: self)
        self.presenter = ChangeCityPresenter(router: router, completion)
    }

    
    @IBAction func getCityWeather(_ sender: UIButton) {
        if let city = self.cityTextField.text {
            presenter.getWeatherFrom(city: city)
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        presenter.goBack()
    }
}
