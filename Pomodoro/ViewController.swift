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
    var targetTime = 25*60
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
    }
    func updateTime(){
        let endTime = NSDate.timeIntervalSinceReferenceDate()
        let time = Int(endTime-startTime)
        if time >= targetTime {
            timer.invalidate()
        }
        let min = (targetTime-time)/60 > 9 ? String((targetTime-time)/60) : "0"+String((targetTime-time)/60)
        let sec = (targetTime-time)%60 > 9 ? String((targetTime-time)%60) : "0"+String((targetTime-time)%60)

        timeLabel.text = "\(min):\(sec)"
        println("time=\(time) , count down=\(min):\(sec)")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

