//
//  WeatherDataBaseManager.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Foundation
import RealmSwift

public class WeatherDatabaseManager {

    private static var sharedInstance : WeatherDatabaseManager{
        return WeatherDatabaseManager()
    }
    public class func shared() -> WeatherDatabaseManager {
        return sharedInstance
    }

    public func setup(config: Realm.Configuration) {
        WeatherDatabaseService.configureDataMigration(config: config)
    }
}
