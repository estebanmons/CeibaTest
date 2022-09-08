//
//  CoreDataManager.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit
import CoreData

enum StoredUsersResult {
    case success([UserModel])
    case error
}

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    func saveData(users: [UserModel], completionHandler: @escaping (Bool) -> Void) {
        deleteUsers()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        users.forEach { user in
            let userEntity = Users(context: context)
            userEntity.id = Int64(user.id)
            userEntity.name = user.name
            userEntity.phone = user.phone
            userEntity.email = user.email
        }
        
        do {
            try context.save()
            completionHandler(true)
        } catch {
            print("Error saving")
        }
    }

    func getStoredData(completionHandler: @escaping (StoredUsersResult) -> Void) {
        var users = [UserModel]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            
            result.forEach { user in
                guard let name = user.name,
                      let phone = user.phone,
                      let email = user.email
                else {
                    return
                }
                
                users.append(UserModel(email: email, id: Int(user.id), name: name, phone: phone))
            }
            
            if result.count > 0 {
                completionHandler(.success(users))
            } else {
                completionHandler(.error)
            }
        } catch {
            print("El error obteniendo usuario(s) \(error)")
        }
    }

    func deleteUsers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        let deleteBatch = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteBatch)
        } catch {
            print("Error Borrando los usuarios \(error)")
        }
    }
}
