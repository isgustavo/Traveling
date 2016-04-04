//
//  AirlineDAO.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/1/16.
//  Copyright © 2016 Pé de pano. All rights reserved.
//

import UIKit
import CoreData

class AirlineBrazil {
    
    static let sharedInstance = AirlineBrazil()
    private var airlines: [String] = []
    
    private init(){
        airlines.append("Avianca Brasil")
        airlines.append("Azul Linhas Aéreas Brasileiras")
        airlines.append("Gol Transportes Aéreos")
        airlines.append("TAM Linhas Aéreas")
    }
    
    func getAirline(row: Int) -> String {
        return self.airlines[row]
    }
    
    func getAirlines() -> [String] {
        return self.airlines
    }
}

class AirlineDAO {

    // insert new object
    static func insertAll() -> Bool {
        
        var airlines = DatabaseManager.sharedInstance.managedObjectContext.insertedObjects as! Set<Airline>
        
        for airline in AirlineBrazil.sharedInstance.getAirlines() {
            let newAirline = Airline()
            newAirline.airlineName = airline
            airlines.insert(newAirline)
        }
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            return true
            
        } catch let error as NSError {
            print("Erro ao inserir tarefa: ", error)
            return false
        }
    }
    
    // fetch all existing objects
    static func fetchAll() -> [Airline] {
        
        let request = NSFetchRequest(entityName: "Airline")
        
        var results = [Airline]()
        
        do {
            results = try DatabaseManager.sharedInstance.managedObjectContext.executeFetchRequest(request) as! [Airline]
            
        } catch let error as NSError {
            print("Erro ao buscar tarefas:", error)
        }
        
        return results
    }
    
}
