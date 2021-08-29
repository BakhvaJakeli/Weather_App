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
    private var dailyDataArray = [DailyWeatherModel]()
    var myDictionary: [String: [DailyList]] = [:]
    var dictionaryKeys = [String]()
    
    
    init(with tableView: UITableView, dailyWeatherData: DailyWeatherModel) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.dailyWeatherData = dailyWeatherData
    }
    
    
    func createArrayForSections(start: Int = 0) {
        guard let list = dailyWeatherData?.list else { return }
        let i = start
        let og = list[i].dtTxt.prefix(10)
        dictionaryKeys.append(String(og))
        guard start != list.count else { return }
        for index in i ..< list.count {
            if list[index].dtTxt.prefix(10) == og {
                var array = myDictionary[(String(og))] ?? []
                array.append(list[index])
                myDictionary[String(og)] = array
            } else {
                createArrayForSections(start: index)
                break
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
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
        return myDictionary.keys.count//5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let dailyWeatherData = dailyWeatherData else { return 0 }
        let key = String(dailyWeatherData.list[section].dtTxt.prefix(10))
        return myDictionary[key]?.count ?? 0
//        if section == 0 {
//
//            let currentDate = setUpcurrentdate()
//            let rowInSection = dailyWeatherData.list.filter{ $0.dtTxt.contains("\(currentDate.0)-\(currentDate.1)-\(currentDate.2)") }.count
//            if rowInSection <= 0 {
//                return 1
//            } else {
//                return rowInSection
//            }
//        }
//        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let dailyWeatherData = dailyWeatherData else { return UITableViewCell() }
        
        let cell = tableView.deque(DailyWeatherTableViewCell.self, for: indexPath) as DailyWeatherTableViewCell
//        let hdr = tableView.header
        let list = myDictionary[dictionaryKeys[indexPath.section]]//?[indexPath.row]
        guard list?[indexPath.row] != nil else {
            return UITableViewCell()
            
        }
        
        let dly = list?[indexPath.row]
        
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(dly?.weather.first?.icon ?? "")@2x.png") else {
            return UITableViewCell()
            
        }
        
        cell.theImg.kf.setImage(with: url)
        cell.descriptionLbl.text = dly?.weather.first?.weatherDescription.rawValue
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
//        let dt12 = Date.init(timeIntervalSince1970: TimeInterval(dly?.dt ?? 0))
//        let hr = Calendar.current.component(.hour, from: dt12)
//        let mm = Calendar.current.component(.minute, from: dt12)
        let newDate = formatter.date(from: dly?.dtTxt ?? "")
        let hr = Calendar.current.component(.hour, from: newDate!)
        let mm = Calendar.current.component(.minute, from: newDate!)
        cell.timeLabel.text = "\(hr):\(mm)"
        cell.tempLabel.text = "\((dly?.main.temp ?? 0) - 273.15)°"
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    

}
