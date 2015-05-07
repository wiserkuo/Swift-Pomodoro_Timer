//
//  ViewController.swift
//  Pomodoro
//
//  Created by Wiser Kuo on 2015/4/27.
//  Copyright (c) 2015年 sw5. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    var startTime = NSTimeInterval()
    var targetTime :Int?
    var timer = NSTimer()
    var status :Int?
    let managedObjectContext = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
    
    @IBOutlet weak var nameTextField: UITextField!
    
    
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
            println("end 25")
            status = 1
            timeLabel.text = "05:00"
            self.view.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            //CoreData
            var record : Record
            record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: managedObjectContext!) as! Record
            if nameTextField.text == "" {
                record.name = "New task"
            }
            else {
                record.name = nameTextField.text
            }
            record.note = ""
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var dateString = dateFormatter.stringFromDate(NSDate())
            record.date=dateString
            var e: NSError?
            if !managedObjectContext!.save(&e){
                println("inser error: \(e!.localizedDescription)")
                return
            }

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
                //CoreData
                var record : Record
                record = NSEntityDescription.insertNewObjectForEntityForName("Record", inManagedObjectContext: managedObjectContext!) as! Record
                if nameTextField.text == "" {
                    record.name = "New task"
                }
                else {
                    record.name = nameTextField.text
                }
                record.note = ""
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                var dateString = dateFormatter.stringFromDate(NSDate())
                record.date=dateString
                var e: NSError?
                if !managedObjectContext!.save(&e){
                    println("inser error: \(e!.localizedDescription)")
                    return
                }
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
    @IBAction func cancel(segue:UIStoryboardSegue){
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.9, green: 0, blue: 0, alpha: 1)
        status=0
        targetTime = 25*60
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        println("viewWillAppear")
        println("selectedDate1=\(selectedDate)")
        let fetchRequest = NSFetchRequest(entityName: "Record")
        var error:NSError?
        
        if selectedDate == nil {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            selectedDate = dateFormatter.stringFromDate(NSDate()) //today
            
        }
        let pred = NSPredicate(format: "(date = %@)", "\(selectedDate)")
        fetchRequest.predicate = pred
        
        recordsData = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as![Record]
        
        if error != nil {
            println("Failed ti retrieve record: \(error!.localizedDescription)")
        }
        
        //self.view.insertSubview(searcher.searchBar, atIndex: 1)
        //searcher.searchBar.setTranslatesAutoresizingMaskIntoConstraints(false)
        /*searchBarView.addConstraint(NSLayoutConstraint(item:  searcher.searchBar , attribute: .Top , relatedBy: .Equal , toItem: searcher.searchBar.superview, attribute: .Top, multiplier: 1.0, constant: 0.0))
        searchBarView.addConstraint(NSLayoutConstraint(item:  searcher.searchBar , attribute: .Leading , relatedBy: .Equal , toItem: searcher.searchBar.superview, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        searchBarView.addConstraint(NSLayoutConstraint(item:  searcher.searchBar , attribute: .Trailing , relatedBy: .Equal , toItem: searcher.searchBar.superview, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
        searcher.searchBar.sizeToFit()
        */

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

