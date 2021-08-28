//
//  CurrentWeatherManager.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//
import CoreLocation
import Foundation

protocol CurrentWeatherManagerProtocol: AnyObject {
    func fetchCurrentWeather(location: CLLocation, completion: @escaping (([CurrentWeatherModel]) -> Void))
}

class CurrentWeatherManager: CurrentWeatherManagerProtocol {

    func fetchCurrentWeather(location: CLLocation, completion: @escaping (([CurrentWeatherModel]) -> Void)) {
        let url = "api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=8f20dce1cb8568bef98332f9e23996fc"
        NetworkManager.shared.get(url: url) { (result: Result<[CurrentWeatherModel], Error>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
