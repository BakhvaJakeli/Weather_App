//
//  CurrentWeather.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit

class CurrentWeather: UIViewController {
    
    private var viewModel: CurrentWeatherViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.setUpDarkMode(with: self.view, lightCollor: UIColor.white, darkCollor: UIColor.darkGray)
    }
}

extension CurrentWeather {
    
    func configureViewModel() {
        viewModel = CurrentWeatherViewModel(with: self)
    }
    
}
