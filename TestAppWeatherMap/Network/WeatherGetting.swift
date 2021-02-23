//
//  WeatherGetting.swift
//  TestAppWeatherMap
//
//  Created by pioner on 18.02.2021.
//

import UIKit

class WeatherGetting {
    
    let apiKey = "5e4542464d46afbd0f65df9f1e34c741"
    let baseUrlStr = "http://api.openweathermap.org/data/2.5/weather"
    let urlImgStr = "http://openweathermap.org/img/wn/"
    
    var urlComps: URLComponents! {
        var components = URLComponents(string: baseUrlStr)
        components?.queryItems = self.queryItems
        return components
    }
    
    var queryItems = [
        URLQueryItem(name: "units", value: "metric")
    ]
    
    init(){
        queryItems.append(URLQueryItem(name: "appid", value: self.apiKey))
    }
    
    func get(items: [URLQueryItem], completionHandler: @escaping (WeatherFull) -> Void) {
        
        queryItems += items
        
        guard let url = urlComps.url else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data, let response = response else {
                print("no data or respone")
                return
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                print("no httpUrlResponse")
                return
            }
            
            if httpUrlResponse.statusCode != 200 {
                print("status code is not 200")
                return
            }
            
            do {
                
                let res = try JSONDecoder().decode(WeatherFull.self, from: data)
                completionHandler(res)
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    func getFromCoordinate(latitude: Float, longitude: Float, completionHandler: @escaping (WeatherFull) -> Void) {
        get(items: [URLQueryItem(name: "lat", value: String(latitude)),URLQueryItem(name: "lon", value: String(longitude))],completionHandler: completionHandler)
    }
    
    func getImage(code: String, size: String = "", completionHandler: @escaping (UIImage?) -> Void ){
        let urlStr = self.urlImgStr + code + (size == "" ? "" : "@" + size + "x") + ".png"

        guard let url = URL(string: urlStr) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, request, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data, let _ = request else {
                print("no data or request")
                return
            }
            
            completionHandler(UIImage(data: data))
            
        }.resume()
    }
    
    
}
