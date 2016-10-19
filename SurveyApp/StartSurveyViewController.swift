//
//  StatSurveyViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/14/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class StartSurveyViewController: UIViewController {
    @IBAction func nextScreen(sender: AnyObject) {
        //performSegueWithIdentifier("startToQuestions", sender: self)
        performSegueWithIdentifier("toQuestions", sender: self)
    }
}
