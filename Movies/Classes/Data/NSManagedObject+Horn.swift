//
//  NSManagedObject+Horn.swift
//  Movies
//
//  Created by Sebastian Romero on 11/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import UIKit
import CoreData

extension NSManagedObject {
    
    
    /// Creates a context
    ///
    /// - returns: instance of the object
    class func create() -> Self {
        return createInContext()
    }
    
    
    class func createUnique(attribute:String, value:String) -> Self {
        let response = find(attributes: [[attribute, "=\(value)"]])
        if response.count > 0 {
            return safeResponse(response: response)!
        }
        return createInContext()
    }
    
    
    /// Help within the class instance putting a generic
    ///
    /// - returns: instance of the object
    private class func createInContext<T>() -> T {
        let object = NSEntityDescription.insertNewObject(forEntityName: className(), into: CoreDataManager.sharedManager.context) as! T
        return object
    }
    
    
    
    /// Evaluates the response and returns the instance of the object, if is empty retunrs nil
    ///
    /// - parameter response: valid managed object response
    ///
    /// - returns: intance of the object
    private class func safeResponse<T>(response:[NSManagedObject]) -> T? {
        var data:T? = nil
        if response.count > 0 {
            data = response.first as? T
        }
        return data
    }
    
    
    
    /// Returns the class name
    ///
    /// - returns: string with the class name
    class func className() -> String {
        let classString = NSStringFromClass(self)
        return classString
    }
    
    
    
    /// Performs a query and gets the first element of the dataset
    ///
    /// - parameter attribute: where statement
    /// - parameter value:     value to search for
    ///
    /// - returns: first instance of the object
    class func get(attribute:String, value:String) -> Self? {
        let response = find(attributes: [[attribute, value]])
        return safeResponse(response: response)
    }
    
    
    
    class func getFirst() -> Self? {
        let allRecords = all()
        return safeResponse(response: allRecords)
    }
    
    
    
    
    /// Returns all elements of the model
    ///
    /// - returns: array within all elements from the dataset
    class func all() -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: className())
        do {
            guard let objects = try CoreDataManager.sharedManager.context.fetch(request) as? [NSManagedObject] else {
                return []
            }
            return objects
        } catch {
            return []
        }
    }
    
    
    
    static func fetchCountFor(entityName: String, predicate: NSPredicate, onMoc moc: NSManagedObjectContext) -> Int {
        var count: Int = 0
        moc.performAndWait {
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
            fetchRequest.predicate = predicate
            fetchRequest.resultType = NSFetchRequestResultType.countResultType
            do {
                count = try moc.count(for: fetchRequest)
            } catch {
                //Assert or handle exception gracefully
            }
        }
        return count
    }
    
    
    
    internal class func getRequest(attributes:[[String]],
                                   order:String? = nil,
                                   ascending:Bool = true,
                                   limit:Int = 0,
                                   offset:Int = 0) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: className())
        var predicates:[NSPredicate] = []
        for attribute in attributes {
            let predicate = NSPredicate(format: "(\(attribute[0]) \(attribute[1]))")
            predicates.append(predicate)
        }
        let predicate:NSPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.predicate = predicate
        if let validOrder = order {
            let sortDescriptor = NSSortDescriptor(key: validOrder, ascending: ascending)
            request.sortDescriptors = [sortDescriptor]
        }
        if limit > 0 {
            request.fetchLimit = limit
            request.fetchOffset =  offset
        }
        return request
    }
    
    
    
    class func find(attributes:[[String]],
                    order:String? = nil,
                    ascending:Bool = true,
                    limit:Int = 0,
                    offset:Int = 0) -> [NSManagedObject]{
        let request = getRequest(attributes: attributes, order: order, ascending: ascending, limit: limit, offset: offset)
        do {
            guard let objects = try CoreDataManager.sharedManager.context.fetch(request) as? [NSManagedObject] else {
                return []
            }
            return objects
        } catch {
            return []
        }
    }
    
    
    
    class func count(attributes:[[String]]) -> Int {
        let request = getRequest(attributes: attributes)
        var count = 0
        do {
            count = try CoreDataManager.sharedManager.context.count(for: request)
        } catch {
            count = 0
        }
        return count
    }
    
    
    
    
    class func max(attribute:String = "",
                   value:String = "",
                   maxAttribute:String, expressionType:NSAttributeType) -> Any? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: className())
        if !value.isEmpty && !attribute.isEmpty {
            let predicate = NSPredicate(format: "\(attribute)=%@", value)
            request.predicate = predicate
        }
        request.resultType = NSFetchRequestResultType.dictionaryResultType
        let keypathExpression = NSExpression(forKeyPath: maxAttribute)
        let maxExpression = NSExpression(forFunction: "max:", arguments: [keypathExpression])
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "max_\(maxAttribute)"
        expressionDescription.expression = maxExpression
        expressionDescription.expressionResultType = expressionType
        request.propertiesToFetch = [expressionDescription]
        do {
            if let result = try CoreDataManager.sharedManager.context.fetch(request) as? [[String: Any]], let dict = result.first {
                return dict["max_\(maxAttribute)"] ?? nil
            }
        } catch {
            assertionFailure("Failed to fetch max timestamp with error = \(error)")
            return nil
        }
        return nil
    }
    
    
    class func search(attribute:String = "",
                      value:String = "",
                      limit:Int = 0,
                      offset:Int = 0) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: className())
        if !value.isEmpty && !attribute.isEmpty {
            let predicate = NSPredicate(format: "\(attribute) contains[c] %@", value)
            request.predicate = predicate
        }
        if limit > 0 && offset > 0{
            request.fetchLimit = limit
            request.fetchOffset =  offset
        }
        do {
            guard let objects = try CoreDataManager.sharedManager.context.fetch(request) as? [NSManagedObject] else {
                return []
            }
            return objects
        } catch {
            return []
        }
    }
    
    
    
    /// Saves the given context
    ///
    /// - returns: returns a boolean to evaluate the process
    func save() -> Bool {
        do {
            try CoreDataManager.sharedManager.context.save()
            return true
        } catch {
            return false
        }
    }
    
    
    /// Deletes a record
    func delete() {
        CoreDataManager.sharedManager.context.delete(self)
    }
    
}
