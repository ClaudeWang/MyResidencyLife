//
//  ThirdQuestionPageController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/1/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class ThirdQuestionPageController: UIViewController{
    
    @IBOutlet var question1Text: UILabel!
    @IBOutlet var question2Text: UILabel!
    
    
    @IBOutlet var question1: UISlider!
    @IBOutlet var question2: UISlider!
    var q1_index = 0;
    var q2_index = 0;
    var initQ1Val: Float?
    var initQ2Val: Float?
    

    @IBAction func nextPage(sender: AnyObject) {
        parent!.goNextPage("")
    }

    @IBAction func toFeedbackPage(sender: AnyObject) {
        //self.performSegueWithIdentifier("questionToFeedback", sender: self)
        parent!.showFeedbackPage();
    }
    
    @IBAction func previousPage(sender: AnyObject) {
        parent!.goPrevPage("")
    }
    var pickerData: [String] = [String]()
    var parent: SurveyAppPageViewController?
    
    var questions = [
        "Poor outcomes are unacceptable.",
        "People should be rewarded for a job well done.",
        "If things are not done well, there is no sense in doing them.",
        "Today, I felt frustrated other people kept me from accomplishing what I have set out to do.",
        "Today, I was irritated by how slowly and ineffectively things move in the hospital. I can always think of ways that things could be done better.",
        "Non-compliant patients get on my nerves",
        "Unhelpful nurses/staff irritate me",
        "I take good care of myself",
        "I’m annoyed when my attending changes my plan or corrects me.",
        "My work assignments and work hours are unreasonable.",
        "My program is out of touch with residents’ personal and professional needs.",
        "It would not be ok with me if I were recognized as a ‘good’ doctor but not a ‘great one.’",
        "The idea that another resident may be outperforming me at work is irritating.",
        "I’m spending a good amount of time with my family",
        "I’m worried about finances",
        "I’m taking good care of myself",
        "I have a pretty good work-life balance",
        "I had very tough cases today",
        "I’m overwhelmed by my to-do list",
        "Whatever I do, it’s never enough",
        "I’m tired",
        "Days like this are why I chose medicine as a career",
        "I can’t wait for my next vacation (next prompt here: do you have a vacation already booked?)",
        "I think I’m growing as a physician",
        "My work impacts people’s lives meaningfully",
        "I’m heard when I give feedback",
        "People care about my opinion",
        "Today, staff was so difficult",
        "People just don’t work hard enough",
        "I can see myself doing this kind of work for a long time",
        "At some point today, I recognized that I helped someone and felt rewarded for doing so",
        "I feel guilty because I don’t make enough time for people I care about",
        "I should study more",
        "I can see why people end up using so much alcohol to relax",
        "I’m a well-rounded physician",
        "I cannot think of the last time I was recognized for something I did well.",
        "I feel there are too many things beyond my control that keep me from being able to do my job well.",
        "If I receive criticism from an upper level or an attending, I become irritated with myself for not performing well"
    ]
    override func viewDidLoad() {
        initQ1Val = question1.value
        initQ2Val = question2.value
        
        q1_index = Int(arc4random_uniform(38))
        q2_index = Int(arc4random_uniform(38))
        while(q2_index == q1_index) {
            q2_index = Int(arc4random_uniform(38))
        }
        question1Text.text = questions[q1_index]
        question2Text.text = questions[q2_index]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectResponse() -> [Int: (Int, Int)] {
        var response = [Int: (Int, Int)]()
        //see changes. If no change, return 150.
        if (question1.value != initQ1Val){
            response[1] = (Int(floor(question1.value * 100)), q1_index)
        }
        else {
            response[1] = (150, q1_index)
        }
        
        if (question2.value != initQ2Val){
            response[2] = (Int(floor(question2.value * 100)), q2_index)
        }
        else {
            response[2] = (150, q2_index)
        }
        return response
    }
    
    internal func setParentController(toSet: SurveyAppPageViewController) {
        parent = toSet
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "questionToFeedback") {
            let dest = segue.destinationViewController as! FeedbackViewController
            print("DEBUG\n")
            print(dest)
            //dest.parent = self.parent
        }
    }
    
}
