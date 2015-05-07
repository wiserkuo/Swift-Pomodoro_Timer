//
//  Map_Tagger.swift
//  Map Tagger
//
//  Created by Wiser Kuo on 2015/4/2.
//  Copyright (c) 2015年 sw5. All rights reserved.
//
import Foundation
import CoreData
var selectedDate:String!
var recordsData:[Record] = []
class Record: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var note: String
    @NSManaged var date: String
}
/*
class MarkerModel: NSObject {
    var name:String
    var coordinate:CLLocationCoordinate2D
    var address:String
    var note: String
    var date: String
    init(name:String , coordinate:CLLocationCoordinate2D , address:String){
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.note = ""
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.stringFromDate(NSDate())
        
        super.init()
    }
}*/