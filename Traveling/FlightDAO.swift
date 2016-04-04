//
//  FlightDAO.swift
//  Traveling
//
//  Created by gustavo.freitas2 on 3/13/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import Foundation
import CoreData

class FlightDAO {
    
    // insert new object
    static func insert(flight: Flight) {
        DatabaseManager.sharedInstance.managedObjectContext.insertObject(flight)
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao inserir tarefa: ", error)
        }
    }
    
    // update existing object
    static func update(flight: Flight) {
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao alterar tarefa: ", error)
        }
    }
    
    // delete object
    static func delete(flight: Flight) {
        DatabaseManager.sharedInstance.managedObjectContext.deleteObject(flight)
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao deletar tarefa:", error)
        }
        
    }
    
    // fetch all existing objects
    static func fetchAllFlight() -> [Flight] {
        
        let request = NSFetchRequest(entityName: "Flight")
        request.sortDescriptors = [NSSortDescriptor(key: "dataHour", ascending:true)]

        var results = [Flight]()
        
        do {
            results = try DatabaseManager.sharedInstance.managedObjectContext.executeFetchRequest(request) as! [Flight]
            
        } catch let error as NSError {
            print("Erro ao buscar tarefas:", error)
        }
        
        return results
    }
}

