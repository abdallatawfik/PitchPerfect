//
//  AudioRecordsTableViewController.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 1/28/18.
//  Copyright © 2018 AT Apps. All rights reserved.
//

import UIKit
import CoreData

class AudioRecordsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var audioRecords:[AudioRecord] {
        get {
            return Model.sharedInstance().getAudioRecords()
        }
    }

    // MARK: - View Controller life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.ToPlaySoundsVC {
            if let playSoundVC = segue.destination as? PlaySoundsViewController {
                if let audioRecord = sender as? AudioRecord {
                    playSoundVC.audioRecord = audioRecord
                }
            }
        }
    }
}

// MARK: - AudioRecordsTableViewController (TableView) datasource and delegate

extension AudioRecordsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioRecords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AudioRecordsTableViewController.AudioRecordCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = audioRecords[indexPath.row].displayName
        cell.detailTextLabel?.text = (audioRecords[indexPath.row].recordingDate! as Date).toString(dateFormat: DateFormats.DisplayDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifiers.ToPlaySoundsVC, sender: audioRecords[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Model.sharedInstance().deleteAudioRecord(audioRecord: audioRecords[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
}
