//
//  ControlPageViewController.swift
//  ResidencyLife
//
//  Created by Ziyun Wang on 10/5/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class ControlPageViewController: UIViewController {

    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let surveyAppPageViewController = segue.destinationViewController as? SurveyAppPageViewController {
            surveyAppPageViewController.controlDelegate = self
        }
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

extension ControlPageViewController: SurveyAppPageControlleDelegate {
    
    func surveyAppPageViewController(surveAppPageViewController: SurveyAppPageViewController, didUpdatePageIndex index: Int) {
            pageControl.currentPage = index
    }
    
    func surveyAppPageViewController(surveAppPageViewController: SurveyAppPageViewController,
        didUpdatePageCount count: Int) {
            pageControl.numberOfPages = count;
    }
}