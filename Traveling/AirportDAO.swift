//
//  AirportDAO.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/14/16.
//  Copyright © 2016 HACKATRUCK. All rights reserved.
//

import Foundation
import CoreData

class AirportDAO {
    
    // insert new object
    static func insert(airport: Airport) -> Bool{
        DatabaseManager.sharedInstance.managedObjectContext.insertObject(airport)
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            return true
            
        } catch let error as NSError {
            print("Erro ao inserir tarefa: ", error)
            return false
        }
    }
    
    static func insertAll() -> Bool {
        
        let airports = DatabaseManager.sharedInstance.managedObjectContext.insertedObjects as! Set<Airport>
        AirportsBrazil.sharedInstance.getAllAirports(airports)

        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            return true
            
        } catch let error as NSError {
            print("Erro ao inserir tarefa: ", error)
            return false
        }
    }
    
    // fetch all existing objects
    static func fetchAll() -> [Airport] {
        
        let request = NSFetchRequest(entityName: "Airport")
        
        var results = [Airport]()
        
        do {
            results = try DatabaseManager.sharedInstance.managedObjectContext.executeFetchRequest(request) as! [Airport]
            
        } catch let error as NSError {
            print("Erro ao buscar tarefas:", error)
        }
        
        return results
    }
    
}

