//
//  AudioRecord+CoreDataProperties.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 2/9/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//
//

import Foundation
import CoreData


extension AudioRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AudioRecord> {
        return NSFetchRequest<AudioRecord>(entityName: "AudioRecord")
    }

    @NSManaged public var fileName: String?
    @NSManaged public var displayName: String?
    @NSManaged public var recordingDate: NSDate?

}
