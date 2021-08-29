//
//  DailyWeatherDataSource.swift
//  Weather_App
//
//  Created by Baxva Jakeli on 29.08.21.
//

import UIKit
import Kingfisher
import CoreLocation

class DailyWeatherDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView!
    private var dailyWeatherData: DailyWeatherModel?
    
    init(with tableView: UITableView, dailyWeatherData: DailyWeatherModel) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.dailyWeatherData = dailyWeatherData
        
    }
    
    
    func setUpcurrentdate() -> (String, String, String) { //Year - 0, Month - 1, Day - 2 //[String] {
        let currentDateTime = Date()
        
        let userCalendar = Calendar.current
        
        let requestedComponents: Set<Calendar.Component> = [
            .year,
            .month,
            .day,
            .hour,
            .minute,
            .second
        ]
        
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        guard let year = dateTimeComponents.year,
              let month = dateTimeComponents.month,
              let day = dateTimeComponents.day else {return ("", "", "")}
        
        return ("\(year)", "\(month)", "\(day)")
        
    }
    
    func getCorrectDate(date: String) -> String {
        if date.count == 1 {
            return "0\(date)"
        }
        return date
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    func getTheDay(_ number: Int) -> String {
        switch number {
        case 1:
            return "SUNDAY"
        case 2:
            return "MONDAY"
        case 3:
            return "TUESDAY"
        case 4:
            return "WEDNSDAY"
        case 5:
            return "THURSDAY"
        case 6:
            return "FRIDAY"
        case 7:
            return "SATURDAY"
        default:
            break
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let dailyWeatherData = dailyWeatherData else {return 0}

        if section == 0 {

            let currentDate = setUpcurrentdate()
            let rowInSection = dailyWeatherData.list.filter{ $0.dtTxt.contains("\(currentDate.0)-\(currentDate.1)-\(currentDate.2)") }.count
            if rowInSection <= 0 {
                return 1
            } else {
                return rowInSection
            }
        }
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let dailyWeatherData = dailyWeatherData else {return UITableViewCell()}
        
        let cell = tableView.deque(DailyWeatherTableViewCell.self, for: indexPath) as DailyWeatherTableViewCell
//        guard let url = URL(string: "https://openweathermap.org/img/wn/\(dailyWeatherData.list[indexPath.row].weather[indexPath.row].icon)@2x.png") else {return UITableViewCell()}
//        cell.theImg.kf.setImage(with: url)
//        cell.descriptionLbl.text = dailyWeatherData.list[indexPath.section].weather[indexPath.row].weatherDescription.rawValue
//        let dt12 = Date.init(timeIntervalSince1970: TimeInterval(dailyWeatherData.list[indexPath.section].dt))
//        let tm = Calendar.current.component(.hour, from: dt12)
//        cell.timeLabel.text = "\(tm)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentDate = setUpcurrentdate()
        guard let number = getDayOfWeek("\(currentDate.0)-\(currentDate.1)-\(currentDate.2)") else {return ""}
        var index = number + section
        if section == 0 {
            return "TODAY"
        } else {
            if index > 7 {
                index = index - 7
            }
            return getTheDay(index)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath)
        
    }
    

}

