//
//  DailyWeatherManager.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 28.08.21.
//

import CoreLocation
import Foundation

protocol DailyWeatherManagerProtocol: AnyObject {
    func fetchDailyWeather(lat: String, long: String, completion: @escaping ((DailyWeatherModel) -> Void))
}

class DailyWeatherManager: DailyWeatherManagerProtocol {

    func fetchDailyWeather(lat: String, long: String, completion: @escaping ((DailyWeatherModel) -> Void)) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=8f20dce1cb8568bef98332f9e23996fc"
        NetworkManager.shared.get(url: url) { (result: Result<DailyWeatherModel, Error>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
