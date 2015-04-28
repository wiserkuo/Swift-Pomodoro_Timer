//
//  ViewController.swift
//  Pomodoro
//
//  Created by Wiser Kuo on 2015/4/27.
//  Copyright (c) 2015年 sw5. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    var startTime = NSTimeInterval()
    var targetTime :Int?
    var timer = NSTimer()
    var status :Int?
    @IBAction func startTapped(sender: AnyObject) {
        println("start")
        timer.invalidate()
        if status == 0 {
            timeLabel.text = "25:00"
            targetTime = 25*60
        }
        else if status == 1 {
            timeLabel.text = "05:00"
            targetTime = 5*60
        }
        println("\(timeLabel.text)")
        timer.invalidate()
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        
    }
    
    @IBAction func endTapped(sender: AnyObject) {
        println("end")
        if status == 0 {
            status = 1
            timeLabel.text = "05:00"
            self.view.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
        }
        else {
            status = 0
            timeLabel.text = "25:00"
            self.view.backgroundColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 1)
        }
        timer.invalidate()
    }
    func updateTime(){
        let endTime = NSDate.timeIntervalSinceReferenceDate()
        let time = Int(endTime-startTime)
        if time >= targetTime {
            if status == 0 {
                status = 1
                timeLabel.text = "05:00"
                self.view.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            }
            else {
                status = 0
                timeLabel.text = "25:00"
                self.view.backgroundColor = UIColor(red: 0.7, green: 0, blue: 0, alpha: 1)
            }
            timer.invalidate()
        }
        let min = (targetTime!-time)/60 > 9 ? String((targetTime!-time)/60) : "0"+String((targetTime!-time)/60)
        let sec = (targetTime!-time)%60 > 9 ? String((targetTime!-time)%60) : "0"+String((targetTime!-time)%60)
        
        timeLabel.text = "\(min):\(sec)"
        println("time=\(time) , count down=\(min):\(sec)")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 1)
        status=0
        targetTime = 25*60
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

