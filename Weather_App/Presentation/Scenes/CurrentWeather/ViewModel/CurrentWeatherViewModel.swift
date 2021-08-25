//
//  CurrentWeatherViewModel.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit

protocol CurrentWeatherViewModelProtocol: AnyObject {
    init(with viewcontroller: UIViewController)
    
    func setUpDarkMode(with view: UIView, lightCollor: UIColor, darkCollor: UIColor)
    func setUpTextDarkMode(with label: UILabel, lightCollor: UIColor, darkCollor: UIColor)
}

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    
    private weak var controller: UIViewController?
    
    init(with viewcontroller: UIViewController) {
        self.controller = viewcontroller
    }
    
    func setUpDarkMode(with view: UIView, lightCollor: UIColor, darkCollor: UIColor) {
        switch controller?.traitCollection.userInterfaceStyle {
        case .dark:
            view.backgroundColor = darkCollor
        case .light:
            view.backgroundColor = lightCollor
        default:
            break
        }
    }
    
    func setUpTextDarkMode(with label: UILabel, lightCollor: UIColor, darkCollor: UIColor) {
        switch controller?.traitCollection.userInterfaceStyle {
        case .dark:
            label.textColor = darkCollor
        case .light:
            label.textColor = lightCollor
        default:
            break
        }
    }
}
