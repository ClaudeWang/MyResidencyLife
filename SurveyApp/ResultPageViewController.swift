//
//  ResultPageViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/1/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {

    private var parent:SurveyAppPageViewController?
    
    @IBAction func previousPage(sender: AnyObject) {
        parent?.goPrevPage("")
    }
    @IBAction func ReportResponse(sender: AnyObject) {
        parent!.collectResponse();
        let alert = UIAlertController(title: "Finish", message: "Congratulations! You have submitted a response!", preferredStyle: UIAlertControllerStyle.Alert)
        func OKHandler(actionTarget: UIAlertAction) {
            finishCurrentSurvey()
        }
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: OKHandler)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    internal func setParentController(toSet: SurveyAppPageViewController) {
        parent = toSet
    }
    
    
    internal func finishCurrentSurvey() {
        performSegueWithIdentifier("resultToStart", sender: self)
    }
}
