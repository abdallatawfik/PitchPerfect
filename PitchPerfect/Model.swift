//
//  Model.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 1/28/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//

import UIKit
import CoreData

class Model {
    
    // MARK: - Properties
    
    let coreDataStack = CoreDataStack(modelName: CoreDataConstants.ModelName)!
    
    // MARK: - Audio Record Management
    
    func addAudioRecord(with filePath:String) -> AudioRecord {
        let audioRecord = AudioRecord(displayName: CoreDataConstants.AudioRecordDefaultDisplayName, fileName: filePath, recordingDate: NSDate(), context: coreDataStack.context)
        try? coreDataStack.saveContext()
        
        return audioRecord
    }
    
    func deleteAudioRecord(audioRecord:AudioRecord) {
        do {
            try FileManager.default.removeItem(atPath: Model.filePath(from: audioRecord.fileName!)!.absoluteString)
        } catch {
            print(String(describing: error));
        }
        
        coreDataStack.context.delete(audioRecord)
        try? coreDataStack.saveContext()
    }
    
    func getAudioRecords() -> [AudioRecord] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataConstants.AudioRecordEntityName)
        
        var fetchedAudioRecords = [AudioRecord]()
        do {
            fetchedAudioRecords = try coreDataStack.context.fetch(fetchRequest) as! [AudioRecord]
        } catch {
            fatalError("Failed to fetch Pins: \(error)")
        }
        
        return fetchedAudioRecords
    }
    
    func update(audioRecord:AudioRecord, with displayName:String) {
        audioRecord.displayName = displayName
        try? coreDataStack.saveContext()
    }
    
    // MARK: File path convenient methods
    
    static func filePath(from fileName:String) -> URL? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let pathArray = [dirPath, fileName]
        return URL(string: pathArray.joined(separator: "/"))
    }
    
    static func fileName(from filePath:URL) -> String {
        return filePath.lastPathComponent
    }
    
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> Model {
        struct Singleton {
            static var sharedInstance = Model()
        }
        return Singleton.sharedInstance
    }
}
