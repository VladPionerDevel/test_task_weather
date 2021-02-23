//
//  PlaceWeatherHandler.swift
//  TestAppWeatherMap
//
//  Created by pioner on 18.02.2021.
//

import Foundation
import CoreData

class PlaceWeatherCDHandler {
    
    let context = CoreDataStack.shared.persistentContainer.viewContext
    
    func createWithoutSave() -> PlaceWeather! {
        return (NSEntityDescription.insertNewObject(forEntityName: String(describing: PlaceWeather.self), into: context) as! PlaceWeather)
    }
    
    func create(
        date: Date?,
        descript: String?,
        icon: String?,
        latitude: Float?,
        longitude: Float?,
        nameFromMap: String?,
        nameFromServer: String?,
        temp: Float?,
        windDeg: Float?,
        windSpeed: Float?
    ) {
        guard let placeWeather = NSEntityDescription.insertNewObject(forEntityName: String(describing: PlaceWeather.self), into: context) as? PlaceWeather else { return }
        
        placeWeather.date = date ?? Date()
        placeWeather.descript = descript
        placeWeather.icon = icon
        placeWeather.latitude = latitude ?? 0
        placeWeather.longitude = longitude ?? 0
        placeWeather.nameFromMap = nameFromMap
        placeWeather.nameFromServer = nameFromServer
        placeWeather.temp = temp ?? 0
        placeWeather.windDeg = windDeg ?? 0
        placeWeather.windSpeed = windSpeed ?? 0
        
        saveContext()
    }
    
    func remove(weather: PlaceWeather){
        context.delete(weather)
        saveContext()
    }
    
    func saveContext() {
        CoreDataStack.shared.saveContext()
    }
    
    func getAll() -> [PlaceWeather]? {
        let fetchRequest = NSFetchRequest<PlaceWeather>(entityName: String(describing: PlaceWeather.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            return try context.fetch(fetchRequest)
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
}
