//
//  FirstQuestionPageController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/31/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class FirstQuestionPageController: UIViewController {
    
    @IBOutlet var question1_text: UILabel!

    @IBOutlet var question2_text: UILabel!
    
    @IBOutlet var question3_text: UILabel!
    
    @IBAction func nextPage(sender: AnyObject) {
        parent!.goNextPage("")
    }
    @IBAction func previousPage(sender: AnyObject) {
        parent!.goPrevPage("")
    }

    private var parent:SurveyAppPageViewController?
    
    @IBOutlet var question1: UISlider!
    
    @IBOutlet var question2: UISlider!
    
    @IBOutlet var question3: UISlider!
    
    var q1_index = 0;
    var q2_index = 0;
    var q3_index = 0;
    
    var initQ1Val: Float?;
    var initQ2Val: Float?;
    var initQ3Val: Float?;
    
    var emotional = [
        "I feel emotionally drained from my work.",
        "I feel used up at the end of the workday.",
        "I feel fatigued when I get up in the morning and have to face another day at work.",
        "Working all day with people is a real strain for me.",
        "I feel burned out from my work.",
        "I feel frustrated by my job.",
        "I feel I’m working too hard on my job.",
        "Working with people directly puts too much stress on me.",
        "I feel like I’m at the end of my rope."
    ]
    
    var depersonilization = [
        "I can easily understand how my patients feel about things.",
        "I feel I treat some patients as if they were impersonal objects.",
        "I’ve become more callous towards people since I took this job.",
        "I worry that this job is hardening me emotionally.",
        "I don’t really care what happens to some of my patients.",
        "I can easily create a relaxed atmosphere with my patients.",
        "I feel patients blame me for some of their problems."
    ]
    
    var personal_achievement = [
        "I deal very effectively with the problems of my patients.",
        "I feel I am positively influencing other people’s lives through my work.",
        "I feel very energetic.",
        "I feel exhilarated after working closely with my patients.",
        "I have accomplished many worthwhile things in this job.",
        "In my work, I deal with emotional problems very calmly."
    ]
    
    override func viewDidLoad() {
        //intitialize the slider to be zero.
        q1_index = Int(arc4random_uniform(9))
        q2_index = Int(arc4random_uniform(7))
        q3_index = Int(arc4random_uniform(6))
        
        question1_text.text = emotional[q1_index]
        question2_text.text = depersonilization[q2_index]
        question3_text.text = personal_achievement[q3_index]
        
        initQ1Val = question1.value;
        initQ2Val = question2.value;
        initQ3Val = question3.value;
    }
    
    internal func setParentController(toSet: SurveyAppPageViewController) {
        parent = toSet
    }

    internal func collectResponse()->[Int: (Int, Int)] {
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
        
        if (question3.value != initQ3Val){
            response[3] = (Int(floor(question3.value * 100)), q3_index)
        }
        else {
            response[3] = (150, q3_index)
        }
        return response
    }
}
