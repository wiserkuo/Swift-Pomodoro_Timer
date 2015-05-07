//
//  RecordViewController.swift
//  Pomodoro
//
//  Created by wiserkuo on 2015/5/7.
//  Copyright (c) 2015年 sw5. All rights reserved.
//

import UIKit
import CoreData

class RecordViewController: UITableViewController ,UIActionSheetDelegate {
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    

    
    
    var datePicker : UIDatePicker!
    var actionSheet : UIActionSheet!
    func createDatePickerViewWithAlertController()
    {
        var viewDatePicker: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        viewDatePicker.backgroundColor = UIColor.clearColor()
        self.datePicker = UIDatePicker(frame: CGRectMake(0, 0, self.view.frame.size.width, 200))
        self.datePicker.datePickerMode = UIDatePickerMode.Date
        
        //self.datePicker.addTarget(self, action: "datePickerSelected", forControlEvents: UIControlEvents.ValueChanged)
        viewDatePicker.addSubview(self.datePicker)
        if(UIDevice.currentDevice().systemVersion >= "8.0")
        {
            
            let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alertController.view.addSubview(viewDatePicker)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel)
                { (action) in
                    // ...
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "Done", style: .Default)
                { (action) in
                    
                    self.dateSelected()
                    println("Done selectedDate=\(selectedDate)")
            }
            alertController.addAction(OKAction)
            
            /*
            let destroyAction = UIAlertAction(title: "Destroy", style: .Destructive)
            { (action) in
            println(action)
            }
            alertController.addAction(destroyAction)
            */
            self.presentViewController(alertController, animated: true)
                {
                    // ...
            }
        }
        else
        {
            println("UIAlertSheet")
            actionSheet = UIActionSheet(title: "\n\n\n\n\n\n\n\n\n\n", delegate: self, cancelButtonTitle: nil, destructiveButtonTitle: nil )
            
            self.datePicker.frame.origin.y = 44
            
            var pickerDateToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 44))
            
            pickerDateToolbar.barStyle = UIBarStyle.Black
            
            var barItems = NSMutableArray()
            
            var doneButton = UIBarButtonItem(title: "Done",style: UIBarButtonItemStyle.Done, target: self, action: "doneIOS7Date:")
            
            barItems.addObject(doneButton)
            
            var cancelButton = UIBarButtonItem(title: "Cancel",style: UIBarButtonItemStyle.Plain, target: self, action: "cancelIOS7Date:")
            
            barItems.addObject(cancelButton)
            
            pickerDateToolbar.setItems(barItems as [AnyObject], animated: true)
            
            actionSheet.addSubview(pickerDateToolbar)
            
            actionSheet.addSubview(datePicker)
            
            actionSheet.showInView(self.view)
            
        }
        
    }
    func doneIOS7Date(doneButton: UIBarButtonItem){
        println("done")
        self.dateSelected()
        println("Done selectedDate=\(selectedDate)")
        actionSheet.dismissWithClickedButtonIndex(0, animated: true)
    }
    func cancelIOS7Date(doneButton: UIBarButtonItem){
        println("cancel")
    }
    func dateformatterDateTime(date: NSDate) -> NSString
    {
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.stringFromDate(date)
    }
    func dateSelected()
    {
        // var selectedDate: String = String()
        selectedDate = self.dateformatterDateTime(datePicker.date) as String
        self.title = selectedDate
        
        let fetchRequest = NSFetchRequest(entityName: "Record")
        var error:NSError?
        
        let pred = NSPredicate(format: "(date = %@)", "\(selectedDate)")
        fetchRequest.predicate = pred
        
        let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Record]?
        if let results = fetchResults {
            recordsData = results
            
        }
        self.tableView.reloadData()
        // self.textFieldFromDate.text =  selectedDate
        println("dateSelected() selectedDate=\(selectedDate)")
    }
    
    @IBAction func dateTapped(sender: AnyObject) {
        println("dateTapped")
        createDatePickerViewWithAlertController()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        println("selectedDate1=\(selectedDate)")
        let fetchRequest = NSFetchRequest(entityName: "Record")
        var error:NSError?
        
        if selectedDate == nil {
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            selectedDate = dateFormatter.stringFromDate(NSDate())
            
        }
        let pred = NSPredicate(format: "(date = %@)", "\(selectedDate)")
        fetchRequest.predicate = pred
        
        let fetchResults = managedObjectContext.executeFetchRequest(fetchRequest, error: &error) as! [Record]?
        if let results = fetchResults {
            recordsData = results
            
        }
        else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        self.title = selectedDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return recordsData.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = recordsData[indexPath.row].name
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
