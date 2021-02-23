//
//  WeatherLocalViewController.swift
//  TestAppWeatherMap
//
//  Created by pioner on 18.02.2021.
//

import UIKit

class WeatherLocalViewController: UIViewController {
    
    let weatherGetting = WeatherGetting()
    let weatherCDHandler = PlaceWeatherCDHandler()
    var weather: WeatherFull? = nil
    
    var latitude: Float!
    var longitude: Float!
    var nameFromMap: String!
    
    var date = Date()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        nameLabel.text = nameFromMap ?? ""
        setDataWeather()
    }
    
    
    func setDataWeather() {
        guard let lantitude = self.latitude, let longitude = self.longitude else {return}
        
        weatherGetting.getFromCoordinate(latitude: lantitude, longitude: longitude) { [self] (weatherFromServer) in
            
            weather = weatherFromServer
            
            DispatchQueue.main.async { [self] in
                
                self.descriptionLabel.text = (weatherFromServer.weather!.first!.description ?? "").capitalizingFirstLetter()
                
                self.windSpeedLabel.text = ((weatherFromServer.wind?.speed) != nil) ? (String(weatherFromServer.wind!.speed!)  + " m/s") : ""
                
                self.tempLabel.text = ((weatherFromServer.main?.temp) != nil) ? (String((weatherFromServer.main!.temp)!)  + " °C") : ""
                
                if let imgCode = weatherFromServer.weather!.first!.icon {

                    weatherGetting.getImage(code: imgCode, size: "2") { (img) in
                        guard let img = img else {return}
                        DispatchQueue.main.async { [self] in
                            self.iconImageView.image = img
                        }
                    }

                }
                
            }
            
        }
    }
    
    @objc func saveTapped() {
        guard let weather = weather else {return}
        
        weatherCDHandler.create(
            date: date,
            descript: (weather.weather!.first!.description ?? "").capitalizingFirstLetter(),
            icon: weather.weather?.first?.icon,
            latitude: latitude,
            longitude: longitude,
            nameFromMap: nameFromMap,
            nameFromServer: weather.name,
            temp: weather.main?.temp,
            windDeg: weather.wind?.deg,
            windSpeed: weather.wind?.speed
        )
        
        
    }
    
    

}
