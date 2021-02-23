//
//  ListWeathersViewController.swift
//  TestAppWeatherMap
//
//  Created by pioner on 19.02.2021.
//

import UIKit

class ListWeathersViewController: UIViewController {
    
    @IBOutlet weak var weathersTableView: UITableView!
    
    let weatherGetting = WeatherGetting()
    
    let placeWeatherHandler = PlaceWeatherCDHandler()
    var weathers: [PlaceWeather] {
        guard let weathers = placeWeatherHandler.getAll() else {
            return []
        }
        return weathers
    }
    
    let identifierCell = String(describing: WeatherCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        setWeatherTable()
    }
    
    private func setWeatherTable(){
        let nib = UINib(nibName: identifierCell, bundle: nil)
        weathersTableView.register(nib, forCellReuseIdentifier: identifierCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weathersTableView.reloadData()
    }
    
}

extension ListWeathersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = weathersTableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath) as? WeatherCell else {
            return UITableViewCell()
        }
        
        var dateString = ""
        if let dateWeather =  weathers[indexPath.row].date {
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateString = format.string(from: dateWeather)
        }
        
        if let icon = weathers[indexPath.row].icon {
            weatherGetting.getImage(code: icon) { (image) in
                DispatchQueue.main.async {
                    cell.iconImageView.image = image
                }
            }
        }
        
        cell.nameLabel.text = weathers[indexPath.row].nameFromMap
        cell.dateTimeLabel.text = dateString
        cell.tempLabel.text = String(weathers[indexPath.row].temp)
        cell.descriptionLabel.text = weathers[indexPath.row].descript
        
        return cell
    }
    
}

extension ListWeathersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            placeWeatherHandler.remove(weather: weathers[indexPath.row])
        }
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .right)
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: String(describing: DetailWeatherViewController.self)) as? DetailWeatherViewController else {return}
        
        vc.weather = weathers[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
