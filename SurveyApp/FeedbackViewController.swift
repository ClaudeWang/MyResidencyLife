//
//  FeedbackViewController.swift
//  MyResidencyLife
//
//  Created by Ziyun Wang on 10/9/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    @IBAction func goToRelaxing(sender: AnyObject) {
        parent!.touched = true
        parent!.collectResponse();
        let alert = UIAlertController(title: "Finish", message: "Congratulations! You have submitted a response! You have submitted the reponse. Enjoy your relaxing time. There is no need to come back to the app later.", preferredStyle: UIAlertControllerStyle.Alert)
        func OKHandler(actionTarget: UIAlertAction) {
            finishCurrentSurvey()
            openUrl("https://itunes.apple.com/ie/podcast/60-seconds-solitude-quick/id1079223759?mt=2")
        }
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: OKHandler)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    @IBOutlet var feedBackText: UITextView!
    var parent: SurveyAppPageViewController?
    @IBAction func saveAndSubmit(sender: AnyObject) {
        //go to the start page to Submit.
        parent!.collectResponse();
        let alert = UIAlertController(title: "Finish", message: "Congratulations! You have submitted a response!", preferredStyle: UIAlertControllerStyle.Alert)
        func OKHandler(actionTarget: UIAlertAction) {
            finishCurrentSurvey()
        }
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: OKHandler)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "dismissKeyboard")
        toolbarDone.items = [barBtnDone]
        feedBackText.inputAccessoryView = toolbarDone
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    func openUrl(url:String!) {
        
        let targetURL=NSURL(string: url)
        
        let application=UIApplication.sharedApplication()
        
        application.openURL(targetURL!);
        
    }
    
    func finishCurrentSurvey() {
        //segue to the start view controller.
        self.performSegueWithIdentifier("feedbackToStart", sender: self)
    }
    
    func test() {
        print(feedBackText.text)
    }
    
    func getLength() -> Int {
        if (feedBackText == nil) {
            return 0;
        }
        return feedBackText.text.characters.count
    }
    
    internal func setParentController(toSet: SurveyAppPageViewController) {
        parent = toSet
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
