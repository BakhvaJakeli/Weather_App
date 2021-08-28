//
//  CurrentWeather.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit
import CoreLocation

class CurrentWeather: UIViewController {
    
    private var viewModel: CurrentWeatherViewModelProtocol!
    private var newsManager: CurrentWeatherManagerProtocol!

    @IBOutlet weak var bigCircleImg: UIImageView!
    @IBOutlet weak var rainyCloudImg: UIImageView!
    @IBOutlet weak var dropletImg: UIImageView!
    @IBOutlet weak var windSpeedImg: UIImageView!
    @IBOutlet weak var windImg: UIImageView!
    @IBOutlet weak var compassImg: UIImageView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.setUpDarkMode(with: self.view)
        setUpImages()
        setUpVc()
    }
}

extension CurrentWeather:CLLocationManagerDelegate {
    
    func configureViewModel() {
        viewModel = CurrentWeatherViewModel(with: self)
        newsManager = CurrentWeatherManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            
        }
    }
    
    func setUpImages() {
        viewModel.setUpIconDarkMode(with: bigCircleImg, firstColor: .systemOrange, secondColor: .orange)
        viewModel.setUpIconDarkMode(with: rainyCloudImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: dropletImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windSpeedImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windImg, firstColor: .systemYellow, secondColor: .yellow)
    }
    
    func setUpVc() {
        let sb = UIStoryboard(name: "DailyWeather", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DailyWeather")
        title = "Today"
        tabBarItem.image = UIImage(named: "sun")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {return}
        print("ma neme jeff\(locValue.coordinate.latitude)")
        newsManager.fetchCurrentWeather(lat: "\(locValue.coordinate.latitude)", long: "\(locValue.coordinate.longitude)") { currentWeather in
            print(currentWeather)
        }
    }
}
