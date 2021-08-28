//
//  CurrentWeatherViewModel.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit

protocol CurrentWeatherViewModelProtocol: AnyObject {
    init(with viewcontroller: UIViewController)
    
    func setUpDarkMode(with view: UIView)
    func setUpTextDarkMode(with label: UILabel, firstColor: UIColor, secondColor: UIColor)
    func setUpIconDarkMode(with imageView: UIImageView, firstColor: UIColor, secondColor: UIColor)
}

final class CurrentWeatherViewModel: CurrentWeatherViewModelProtocol {
    
    private weak var controller: UIViewController?
        
    init(with viewcontroller: UIViewController) {
        self.controller = viewcontroller
    }
    
    
    func setUpDarkMode(with view: UIView) {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemGray6
        } else {
            view.backgroundColor = .white
        }
    }
    
    func setUpTextDarkMode(with label: UILabel, firstColor: UIColor, secondColor: UIColor) {
        if #available(iOS 13.0, *) {
            label.textColor = firstColor
        } else {
            label.textColor = secondColor
        }
    }
    
    func setUpIconDarkMode(with imageView: UIImageView, firstColor: UIColor, secondColor: UIColor) {
        if #available(iOS 13.0, *) {
            imageView.tintColor = firstColor
        } else {
            imageView.tintColor = secondColor
        }
    }
}
