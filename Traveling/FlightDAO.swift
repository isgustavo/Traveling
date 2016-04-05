//
//  FlightDAO.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 3/13/16.
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

