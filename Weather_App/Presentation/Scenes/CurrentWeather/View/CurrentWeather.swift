//
//  CurrentWeather.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 25.08.21.
//

import UIKit

class CurrentWeather: UIViewController {
    
    private var viewModel: CurrentWeatherViewModelProtocol!

    @IBOutlet weak var bigCircleImg: UIImageView!
    @IBOutlet weak var rainyCloudImg: UIImageView!
    @IBOutlet weak var dropletImg: UIImageView!
    @IBOutlet weak var windSpeedImg: UIImageView!
    @IBOutlet weak var windImg: UIImageView!
    @IBOutlet weak var compassImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        viewModel.setUpDarkMode(with: self.view)
        setUpImages()
        setUpVc()
    }
}

extension CurrentWeather {
    
    func configureViewModel() {
        viewModel = CurrentWeatherViewModel(with: self)
    }
    
    func setUpImages() {
        viewModel.setUpIconDarkMode(with: bigCircleImg, firstColor: .systemOrange, secondColor: .orange)
        viewModel.setUpIconDarkMode(with: rainyCloudImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: dropletImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windSpeedImg, firstColor: .systemYellow, secondColor: .yellow)
        viewModel.setUpIconDarkMode(with: windImg, firstColor: .systemYellow, secondColor: .yellow)
    }
    
    func setUpVc() {
//        let sb = UIStoryboard(name: "DailyWeather", bundle: nil)
        let vc = DailyWeather()
        vc.title = "Forecast"
        vc.tabBarItem.image = UIImage(named: "sunny_cloud")
        title = "Today"
        tabBarItem.image = UIImage(named: "sun")
    }
}
