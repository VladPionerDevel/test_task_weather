//
//  DetailWeatherViewController.swift
//  TestAppWeatherMap
//
//  Created by pioner on 22.02.2021.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    let weatherGetting = WeatherGetting()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var weather: PlaceWeather? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDataWeather()
    }
    
    func setDataWeather(){
        if let w = weather {
            nameLabel.text = w.nameFromMap
            descriptionLabel.text = w.descript
            windSpeedLabel.text = String(w.windSpeed) + " m/s"
            tempLabel.text = String(w.temp) + " °C"
            
            weatherGetting.getImage(code: w.icon!, size: "2") { (image) in
                DispatchQueue.main.async { [self] in
                    iconImageView.image = image
                }
            }
            
        } else {
            nameLabel.text = ""
            descriptionLabel.text = ""
            windSpeedLabel.text = ""
            tempLabel.text = ""
        }
        
        
    }
    


}
