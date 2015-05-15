//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Oskar Hasinski on 14.05.15.
//  Copyright (c) 2015 Oskar Hasinski. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recodInProgress: UILabel!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var recordAudioButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    // some comment
    override func viewWillAppear(animated: Bool) {
    
        // some comment
        stopRecordButton.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // some comment
    @IBAction func recordAudio(sender: UIButton) {
        recodInProgress.hidden = false
        stopRecordButton.hidden = false

        //Inside func recordAudio(sender: UIButton)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        // some comment
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        // some comment
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        // some comment
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // some comment
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // some comment
        if(flag) {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            // some comment
            self.performSegueWithIdentifier("pushRecording", sender: recordedAudio)
        } else {
            println("recording was not successful");
            recodInProgress.hidden = true
            stopRecordButton.hidden = true
        }
    }
    
    // some comment
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // some comment
        if(segue.identifier == "pushRecording") {
            
            // some comment
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            playSoundsVC.receivedAudio = sender as! RecordedAudio
            
        }
        
    }
    
    // some comment
    @IBAction func stopRecord(sender: UIButton) {
        // some comment
        recodInProgress.hidden = true
        stopRecordButton.hidden = true

        // some comment
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
}

