//
//  HotelDAO.swift
//  Traveling
//
//  Created by Gustavo F Oliveira on 4/4/16.
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

class HotelDAO {

    // insert new object
    static func insert(hotel: Hotel) {
        DatabaseManager.sharedInstance.managedObjectContext.insertObject(hotel)
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao inserir tarefa: ", error)
        }
    }
    
    // update existing object
    static func update(hotel: Hotel) {
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao alterar tarefa: ", error)
        }
    }
    
    // delete object
    static func delete(hotel: Hotel) {
        DatabaseManager.sharedInstance.managedObjectContext.deleteObject(hotel)
        
        do {
            try DatabaseManager.sharedInstance.managedObjectContext.save()
            
        } catch let error as NSError {
            print("Erro ao deletar tarefa:", error)
        }
        
    }
    
    // fetch all existing objects
    static func fetchAllHotel() -> [Hotel] {
        
        let request = NSFetchRequest(entityName: "Hotel")
        request.sortDescriptors = [NSSortDescriptor(key: "checkIInDate", ascending:true)]
        
        var results = [Hotel]()
        
        do {
            results = try DatabaseManager.sharedInstance.managedObjectContext.executeFetchRequest(request) as! [Hotel]
            
        } catch let error as NSError {
            print("Erro ao buscar tarefas:", error)
        }
        
        return results
    }

}
