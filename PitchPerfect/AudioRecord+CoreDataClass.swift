//
//  AudioRecord+CoreDataClass.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 2/9/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//
//

import Foundation
import CoreData

@objc(AudioRecord)
public class AudioRecord: NSManagedObject {    
    convenience init(displayName:String, fileName:String, recordingDate:NSDate, context:NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: CoreDataConstants.AudioRecordEntityName, in: context) {
            self.init(entity: ent, insertInto: context)
            self.displayName = displayName
            self.fileName = fileName
            self.recordingDate = recordingDate
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
