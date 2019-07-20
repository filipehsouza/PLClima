//
//  ChangeCityRouter.swift
//  PLClima
//
//  Created by FAP on 19/07/19.
//  Copyright © 2019 Filipe Souza. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeCityRouterProtocol {
    func goBack()
}

class ChangeCityRouter: ChangeCityRouterProtocol {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func goBack() {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
}
