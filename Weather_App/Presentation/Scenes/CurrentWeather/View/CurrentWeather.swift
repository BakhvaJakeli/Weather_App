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
    private var currentWeatherManager: CurrentWeatherManagerProtocol!

    @IBOutlet private weak var currentLocation: UILabel!
    @IBOutlet private weak var currentWeather: UILabel!
    @IBOutlet private weak var humidityPercent: UILabel!
    @IBOutlet private weak var rainFall: UILabel!
    @IBOutlet private weak var PreasureLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirection: UILabel!


    @IBOutlet private weak var bigCircleImg: UIImageView!
    @IBOutlet private weak var rainyCloudImg: UIImageView!
    @IBOutlet private weak var dropletImg: UIImageView!
    @IBOutlet private weak var PreasureImg: UIImageView!
    @IBOutlet private weak var windImg: UIImageView!
    @IBOutlet private weak var compassImg: UIImageView!
    
    @IBOutlet private weak var shareBtn: UIButton!
    
    
    @IBOutlet private weak var leadingSecondConstraint: NSLayoutConstraint!
    @IBOutlet private weak var differenceBetweenStackView: NSLayoutConstraint!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareBtn.isHidden = true
        configureViewModel()
        viewModel.setUpDarkMode(with: self.view)
        setUpImages()
        setUpVc()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        handleOrientationChange()
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleOrientationChange()
    }
    @objc private func orientationDidChange( _ sender: Any) {
       handleOrientationChange()
    }
    
    private func handleOrientationChange() {
        if UIDevice.current.orientation.isLandscape {
            leadingSecondConstraint.priority = .defaultLow
            differenceBetweenStackView.priority = .required
        } else {
            leadingSecondConstraint.priority = .required
            differenceBetweenStackView.priority = .defaultLow
        }
        updateViewConstraints()
    }
    
    @IBAction func onShare(_ sender: Any) {
    }
    
}

extension CurrentWeather:CLLocationManagerDelegate {
    
    func configureViewModel() {
        viewModel = CurrentWeatherViewModel(with: self)
        currentWeatherManager = CurrentWeatherManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setUpImages() {
        viewModel.setUpIconDarkMode(with: rainyCloudImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: dropletImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: PreasureImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windImg, firstColor: .systemYellow, secondColor: .yellow)
    }
    
    func setUpVc() {
        guard let tabBaritems = tabBarController?.tabBar.items else {return}
        tabBaritems[0].title = "Today"
        tabBaritems[0].image = UIImage(named: "sun")
        tabBaritems[1].title = "Forecast"
        tabBaritems[1].image = UIImage(named: "sunny_cloud")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {return}
        UIView.animate(withDuration: 3) { [unowned self] in
            self.shareBtn.isHidden = false
        }
        currentWeatherManager.fetchCurrentWeather(lat: "\(locValue.coordinate.latitude)", long: "\(locValue.coordinate.longitude)") { [weak self] currentWeather in
            DispatchQueue.main.async {
                guard let strongself = self else {return}
                strongself.viewModel.manageUI(with: currentWeather, mainPhoto: strongself.bigCircleImg , currentLocation: strongself.currentLocation, currentTemp: strongself.currentWeather, humidityLabel: strongself.humidityPercent, preasureLabel: strongself.PreasureLabel, windSpeedLabel: strongself.windSpeedLabel, windDirecction: strongself.windDirection)
            }
        }
    }
}
