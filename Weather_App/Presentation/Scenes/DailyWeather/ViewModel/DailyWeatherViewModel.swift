//
//  DailyWeatherViewModel.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 29.08.21.
//

import UIKit
import CoreLocation

protocol DailyWeatherViewModelProtocol: AnyObject {
    
    init(with viewcontroller: UIViewController)
        
}

final class DailyWeatherViewModel: DailyWeatherViewModelProtocol {
    
    private weak var controller: UIViewController?
    
    
    init(with viewcontroller: UIViewController) {
        self.controller = viewcontroller
    }
    

}
