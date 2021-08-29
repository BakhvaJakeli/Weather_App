//
//  DailyWeather.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit
import CoreLocation

class DailyWeather: UIViewController {
    
    private var dataSource: DailyWeatherDataSource!
    private var viewModel: DailyWeatherViewModelProtocol!
    private var dailyWeatherManager: DailyWeatherManagerProtocol!
    private var dailyWeatherData: DailyWeatherModel?
    
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var myTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVc()
        myTable.registerNib(class: DailyWeatherTableViewCell.self)
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
}

extension DailyWeather: CLLocationManagerDelegate {
    func configureVc() {
        viewModel = DailyWeatherViewModel(with: self)
        dailyWeatherManager = DailyWeatherManager()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else {return}
        dailyWeatherManager.fetchDailyWeather(lat: "\(locValue.coordinate.latitude)", long: "\(locValue.coordinate.longitude)") {[weak self] dailyWeather in
            self?.dailyWeatherData = dailyWeather
            guard let dailyWeatherData = self?.dailyWeatherData else {return}
            DispatchQueue.main.async { [weak self] in
                self?.dataSource = DailyWeatherDataSource(with:(self?.myTable)!, dailyWeatherData: dailyWeatherData)
                self?.myTable.reloadData()
            }
        }
    }
}
