//
//  ViewController.swift
//  TimerAppExample
//
//  Created by Taranpreet Singh on 22/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var ResetButton: UIButton!
    
    var timer: Timer = Timer()
    var count:Int = 0
    var timerCounting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StartButton.setTitleColor(.green, for: .normal)
        // Do any additional setup after loading the view.
    }

    @IBAction func startTapped(_ sender: Any) {
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            StartButton.setTitle("START", for: .normal)
            StartButton.setTitleColor(UIColor.green, for: .normal)
        } else {
            timerCounting = true
            StartButton.setTitle("STOP", for: .normal)
            StartButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void {
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimerLabel.text = timeString
    }
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int){
        return ((seconds / 3600, ((seconds % 3600)/60), ((seconds % 3600) % 60)))
    }
    func makeTimeString(hours: Int, minutes: Int, seconds: Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    @IBAction func resetTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Reset Timer?", message: "Are you sure you would like to reset the Timer?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { (_) in }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            self.count = 0
            self.timer.invalidate()
            self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
        }))
        self.present(alert, animated: true, completion: nil)
        self.StartButton.setTitle("START", for: .normal)
        self.StartButton.setTitleColor(UIColor.green, for: .normal)
    }
  
}

