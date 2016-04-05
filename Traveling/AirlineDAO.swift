//
//  AirlineDAO.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/1/16.
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

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
