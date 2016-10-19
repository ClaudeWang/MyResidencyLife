//
//  InfoViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/27/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var genderPicker: UIPickerView!
    @IBOutlet var maritalPicker: UIPickerView!
    @IBOutlet var childrenPicker: UIPickerView!
    @IBOutlet var homePicker: UIPickerView!
    @IBOutlet var loanPicker: UIPickerView!
    @IBOutlet var specialtyPicker: UIPickerView!
    
    @IBOutlet var pg4: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var depend: UITextField!
    
    
    var pickerDataGender = ["----", "Male", "Female"]
    var pickerDataMarital = ["----", "Single", "Married", "In relationship", "Separated", "Divorced", "Widowed"]
    var pickerDataChildren = ["0", "1", "2-3", "3+"]
    var pickerDataHome = ["----", "Own", "Rent"]
    var pickerDataLoan = ["----", "N/A","Paying off loans", "In Deferment"]
    var pickerDataSpecialties = ["----", "Emergency Medicine", "Psychiatry"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //add done button to keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "dismissKeyboard")
        toolbarDone.items = [barBtnDone]
        age.inputAccessoryView = toolbarDone
        pg4.inputAccessoryView = toolbarDone
        depend.inputAccessoryView = toolbarDone
        
        
        age.keyboardType = UIKeyboardType.NumberPad
        pg4.keyboardType = UIKeyboardType.NumberPad
        depend.keyboardType = UIKeyboardType.NumberPad
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // set picker to point to the middle.
        genderPicker.selectRow(1, inComponent: 0, animated: false)
        maritalPicker.selectRow(1, inComponent: 0, animated: false)
        childrenPicker.selectRow(1, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishInput(sender: AnyObject) {

        //check basic validity
        //age

        if (!checkAgeAndPG4()) {
            return
        }
        
        //get email and age.
        let age_val = Int(age.text!)!
        let email_val = NSUserDefaults.standardUserDefaults().valueForKey("ID") as! String
        let gender = pickerDataGender[genderPicker.selectedRowInComponent(0)]
        let marital = pickerDataMarital[maritalPicker.selectedRowInComponent(0)]
        let children = pickerDataChildren[childrenPicker.selectedRowInComponent(0)]
        let pg4Value = Int(pg4.text!)!
        let loan = pickerDataLoan[loanPicker.selectedRowInComponent(0)]
        let home = pickerDataHome[homePicker.selectedRowInComponent(0)]
        let specialty = pickerDataSpecialties[specialtyPicker.selectedRowInComponent(0)]
        let dependents = Int(depend.text!)!
        
        let timestamp = NSDate().timeIntervalSince1970
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let client = delegate.client!
        let item = ["age": age_val, "email": email_val, "PG4": pg4Value, "gender": gender, "children": children, "marital": marital, "timestamp": String(timestamp), "specialty": specialty, "loan" : loan, "home": home, "dependents": dependents]
        let itemTable = client.tableWithName("DemographicsItem1")
        itemTable.insert(item as [NSObject : AnyObject]) {
            (insertedItem, error) in
            if (error != nil) {
                print("Error" + error!.description);
            } else {
                print("Item inserted, id: ");
            }
        }
        scheduleNotification()
        performSegueWithIdentifier("infoToStart", sender: self)
    }
    
    func fireAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Go back and change it", style: .Default, handler: nil)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func checkAgeAndPG4() -> Bool{
        if (age.text == "") {
            fireAlert("Age cannot be empty")
            return false
        }
        if (pg4.text == "") {
            fireAlert("PG4 cannot be empty")
            return false
        }
        
        if (depend.text == "") {
            fireAlert("Total Dependencies cannot be empty")
            return false
        }
        //check age to be a number and greater than 18.
        if let age = Int(age.text!) {
            if (age < 18) {
                fireAlert("You have to be over 18 to use the app")
                return false
            }
        } else {
            fireAlert("Please enter valid age")
            return false
        }
        //check pg4 level is a number.
        if ((Int(pg4.text!)) == nil) {
            fireAlert("Please enter the correct PG4 level")
            return false
        }

        return true
    }
    
    //delegate functions for the pickers.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) {
            return pickerDataGender[row]
        }else if (pickerView.tag == 1) {
            return pickerDataMarital[row]
        }else if (pickerView.tag == 2){
            return pickerDataChildren[row]
        }else if (pickerView.tag == 3){
            return pickerDataHome[row]
        }else if (pickerView.tag == 4){
            return pickerDataLoan[row]
        }else {
            return pickerDataSpecialties[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) {
            return pickerDataGender.count
        }else if (pickerView.tag == 1) {
            return pickerDataMarital.count
        }else if (pickerView.tag == 2){
            return pickerDataChildren.count
        }else if (pickerView.tag == 3) {
            return pickerDataHome.count
        }else if (pickerView.tag == 4) {
            return pickerDataLoan.count
        }else {
            return pickerDataSpecialties.count;
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func scheduleNotification() {
        
        //The notification is only scheduled when the user uses it for the first time.
        let notification = UILocalNotification()
        notification.alertTitle = "Burnout Survey"
        notification.alertBody = "It's time for some surveys!"
        notification.alertAction = "open"
        notification.category = "reminderCategory"
        notification.soundName = UILocalNotificationDefaultSoundName
        
        //schedule a notification that pops up every week, with four days a week.
        let scheduleYear = 2016
        let scheduleMonth = 09
        let fixedHour = 20
        let fixedMinute = 00
        let fixedTimeZone = NSTimeZone.defaultTimeZone()
        
        //schedule the notification on Monday
        let dateComponentsMon = NSDateComponents()
        dateComponentsMon.year = scheduleYear
        dateComponentsMon.month = scheduleMonth
        dateComponentsMon.day = 19
        dateComponentsMon.hour = fixedHour
        dateComponentsMon.minute = fixedMinute
        dateComponentsMon.timeZone = fixedTimeZone;
        //schedule the notification on wednesday
        let dateComponentsWed = NSDateComponents()
        dateComponentsWed.year = scheduleYear
        dateComponentsWed.month = scheduleMonth
        dateComponentsWed.day = 21
        dateComponentsWed.hour = fixedHour;
        dateComponentsWed.minute = fixedMinute;
        dateComponentsWed.timeZone = fixedTimeZone;
        //schedule the notification on Friday
        let dateComponentsFri = NSDateComponents()
        dateComponentsFri.year = scheduleYear
        dateComponentsFri.month = scheduleMonth
        dateComponentsFri.day = 23
        dateComponentsFri.hour = fixedHour;
        dateComponentsFri.minute = fixedMinute;
        dateComponentsFri.timeZone = fixedTimeZone;
        //schedule the notification on Sunday
        let dateComponentsSun = NSDateComponents()
        dateComponentsSun.year = scheduleYear
        dateComponentsSun.month = scheduleMonth
        dateComponentsSun.day = 25
        dateComponentsSun.hour = fixedHour;
        dateComponentsSun.minute = fixedMinute;
        dateComponentsSun.timeZone = fixedTimeZone;
        
        
        
        let notification2 = UILocalNotification()
        notification2.alertTitle = "Burnout Survey"
        notification2.alertBody = "It's time for some surveys!"
        notification2.alertAction = "open"
        notification2.category = "reminderCategory"
        notification2.soundName = UILocalNotificationDefaultSoundName
        
        let notification3 = UILocalNotification()
        notification3.alertTitle = "Burnout Survey"
        notification3.alertBody = "It's time for some surveys!"
        notification3.alertAction = "open"
        notification3.category = "reminderCategory"
        notification3.soundName = UILocalNotificationDefaultSoundName
        
        let notification4 = UILocalNotification()
        notification4.alertTitle = "Burnout Survey"
        notification4.alertBody = "It's time for some surveys!"
        notification4.alertAction = "open"
        notification4.category = "reminderCategory"
        notification4.soundName = UILocalNotificationDefaultSoundName
        
        
        notification.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsMon)
        notification.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        notification2.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsWed)
        notification2.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification2)
        
        notification3.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsFri)
        notification3.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification3)
        
        notification4.fireDate = NSCalendar(identifier: NSCalendarIdentifierGregorian)!.dateFromComponents(dateComponentsSun)
        notification4.repeatInterval = NSCalendarUnit.WeekOfYear
        UIApplication.sharedApplication().scheduleLocalNotification(notification4)
    }
}
