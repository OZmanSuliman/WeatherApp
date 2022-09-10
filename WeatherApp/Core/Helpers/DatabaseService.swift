//
//  DatabaseService.swift
//  WeatherApp
//
//  Created by Osman Ahmed on 09/09/2022.
//

import Foundation
import RealmSwift

public typealias DatabaseProtocol = DatabaseReading & DatabaseWriting

// To be used everywhere if needed rather than creating new realm
public var realmMain: Realm?

// MARK: - DatabaseReading

public protocol DatabaseReading {
    func fetchLast<Model: Object>() -> Model?
    func fetch<Model: Object>() -> [Model]
    func fetchWithSort<Model: Object>(by key: String, isAscending: Bool) -> [Model]
    func find<Model: Object>(satisfying predicate: NSPredicate) -> Model?
    func find<Model: Object>(satisfying predicate: NSPredicate) -> [Model]
    func findWithSort<Model: Object>(satisfying predicate: NSPredicate, by key: String, isAscending: Bool) -> [Model]
}

// MARK: - DatabaseWriting

public protocol DatabaseWriting {
    func save<Model: Object>(_ objects: [Model])
    func save<Model: Object>(_ object: Model)
    func update<Model: Object>(_ objects: [Model])
    func update<Model: Object>(_ object: Model)
    func clearDatabase()
    func delete<Model: Object>(object: Model)
    func delete<Model: Object>(objects: [Model])
    func deleteType<Model: Object>(model: Model.Type)
    func findAndDelete<Model: Object>(satisfying predicate: NSPredicate, from objects: [Model])
}

// MARK: - WeatherDatabaseService

public class WeatherDatabaseService {
    static func configureDataMigration(config: Realm.Configuration) {
        do {
            realmMain = try Realm(configuration: config)
        } catch {
            // handle error
            fatalError("realm not initialized, most likely due to old scheme version, increment the realmDatabaseVersion number in app delegate\(error.localizedDescription)")
        }
    }

    public init() {}
}

// MARK: DatabaseReading

extension WeatherDatabaseService: DatabaseReading {
    public func fetchLast<Model: Object>() -> Model? {
        return fetch().last
    }

    public func fetch<Model: Object>() -> [Model] {
        guard let models = realmMain?.objects(Model.self) else { return [] }
        return Array(models)
    }

    public func fetchWithSort<Model: Object>(by key: String, isAscending: Bool = true) -> [Model] {
        guard let models = realmMain?.objects(Model.self).sorted(byKeyPath: key, ascending: isAscending) else { return [] }
        return Array(models)
    }

    public func find<Model: Object>(satisfying predicate: NSPredicate) -> Model? {
        guard let model = realmMain?.objects(Model.self).filter(predicate) else { return nil }
        return model.last
    }

    public func find<Model: Object>(satisfying predicate: NSPredicate) -> [Model] {
        guard let models = realmMain?.objects(Model.self).filter(predicate) else { return [] }
        return Array(models)
    }

    public func findWithSort<Model: Object>(satisfying predicate: NSPredicate, by key: String, isAscending: Bool = true) -> [Model] {
        guard let models = realmMain?.objects(Model.self).filter(predicate).sorted(byKeyPath: key, ascending: isAscending) else { return [] }
        return Array(models)
    }
}

// MARK: DatabaseWriting

extension WeatherDatabaseService: DatabaseWriting {
    public func save<Model: Object>(_ objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.create(Model.self, value: $0, update: .modified) }
        }
    }

    public func save<Model: Object>(_ object: Model) {
        save([object])
    }

    public func update<Model: Object>(_ objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.add($0, update: .modified) }
        }
    }

    public func update<Model: Object>(_ object: Model) {
        update([object])
    }

    public func clearDatabase() {
        try? realmMain?.write {
            realmMain?.deleteAll()
        }
    }

    public func delete<Model: Object>(object: Model) {
        try? realmMain?.write {
            realmMain?.delete(object)
        }
    }

    public func delete<Model: Object>(objects: [Model]) {
        try? realmMain?.write {
            objects.forEach { realmMain?.delete($0) }
        }
    }

    public func deleteType<Model: Object>(model: Model.Type) {
        realmMain?.objects(model.self).forEach { item in
            try! realmMain?.write {
                realmMain?.delete(item)
            }
        }
    }

    public func findAndDelete<Model: Object>(satisfying predicate: NSPredicate, from _: [Model]) {
        guard let filteredModels = realmMain?.objects(Model.self).filter(predicate),
              filteredModels.count > 0 else { return }

        try? realmMain?.write {
            filteredModels.forEach { realmMain?.delete($0) }
        }
    }
}

// MARK: - Migration -

public extension Migration {
    func hadProperty(onType typeName: String, property propertyName: String) -> Bool {
        var hasPropery = false
        enumerateObjects(ofType: typeName) { oldObject, _ in
            hasPropery = oldObject?.objectSchema.properties.contains(where: { $0.name == propertyName }) ?? false
        }
        return hasPropery
    }

    func renamePropertyIfExists(onType typeName: String, from oldName: String, to newName: String) {
        if hadProperty(onType: typeName, property: oldName) {
            renameProperty(onType: typeName, from: oldName, to: newName)
        }
    }
}
