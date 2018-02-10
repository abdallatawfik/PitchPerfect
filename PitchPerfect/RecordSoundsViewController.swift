//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Abdalla Tawfik on 2/10/17.
//  Copyright © 2017 AT Apps. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Properties
    
    var audioRecorder: AVAudioRecorder!
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    // MARK: - View Controller life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        configureUI(recording: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func recordAudio(_ sender: UIButton) {
        let session = AVAudioSession.sharedInstance()
        
        // Called if the RecordPermission is granted
        func startRecording() {
            configureUI(recording: true)
            
            do {
                try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            } catch {
                showAlert(message: Alerts.AudioSessionError)
            }
            
            do {
                try audioRecorder = AVAudioRecorder(url: Model.filePath(from: Date().toString(dateFormat: DateFormats.FileName))!, settings: [:])
            } catch {
                showAlert(message: Alerts.AudioRecorderError)
            }
            
            audioRecorder.delegate = self
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()
        }
        
        switch session.recordPermission() {
        case AVAudioSessionRecordPermission.granted:
            startRecording()
        case AVAudioSessionRecordPermission.denied:
            showAlert(Alerts.RecordingDisabledTitle, message: Alerts.RecordingDisabledMessage)
        case AVAudioSessionRecordPermission.undetermined:
            if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
                session.requestRecordPermission({(granted: Bool)-> Void in
                    if granted {
                        DispatchQueue.main.async {
                            startRecording()
                        }
                    } else{
                        DispatchQueue.main.async {
                            self.showAlert(Alerts.RecordingDisabledTitle, message: Alerts.RecordingDisabledMessage)
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        configureUI(recording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(false)
        } catch {
            showAlert(message: Alerts.AudioSessionError)
        }   
    }
    
    // MARK: - AVAudioRecorder delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            let audioRecord = Model.sharedInstance().addAudioRecord(with: Model.fileName(from: audioRecorder.url))
            performSegue(withIdentifier: SegueIdentifiers.ToPlaySoundsVC, sender: audioRecord)
        } else {
            showAlert(Alerts.RecordingFailedTitle, message: Alerts.RecordingFailedMessage)
        }
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
    
    // MARK: - UI configurations
    
    func configureUI(recording:Bool) {
        if recording {
            recordingLabel.text = RecordSoundsViewController.RecordingMessage
        } else {
            recordingLabel.text = RecordSoundsViewController.TapToRecordMessage
        }
        
        recordButton.isEnabled = !recording
        stopRecordingButton.isEnabled = recording
    }

}

