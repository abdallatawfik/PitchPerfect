//
//  Constants.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 1/31/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//


// MARK: - RecordSoundsViewController Constants

extension RecordSoundsViewController {
    static let RecordingMessage = "Recording in Progress"
    static let TapToRecordMessage = "Tap to Record"
}

// MARK: - RecordSoundsViewController Constants

extension AudioRecordsTableViewController {
    static let AudioRecordCellIdentifier = "AudioRecordCell"
}

// MARK: - Alerts

struct Alerts {
    static let DismissAlert = "Dismiss"
    static let RecordingDisabledTitle = "Recording Disabled"
    static let RecordingDisabledMessage = "You've disabled this app from recording your microphone. Check Settings."
    static let RecordingFailedTitle = "Recording Failed"
    static let RecordingFailedMessage = "Something went wrong with your recording."
    static let AudioRecorderError = "Audio Recorder Error"
    static let AudioSessionError = "Audio Session Error"
    static let AudioRecordingError = "Audio Recording Error"
    static let AudioFileError = "Audio File Error"
    static let AudioEngineError = "Audio Engine Error"
}

// MARK: - Segue Identifiers

struct SegueIdentifiers {
    static let ToPlaySoundsVC = "playAudioRecord"
}

// MARK: - CoreData

struct CoreDataConstants {
    static let ModelName = "Model"
    static let AudioRecordEntityName = "AudioRecord"
    static let AudioRecordDefaultDisplayName = "Nice Sound"
}

// MARK: - Date Formats

struct DateFormats {
    static let FileName = "yyyyMMddHHmmss"
    static let DisplayDate = "MMM dd yyy"
}
