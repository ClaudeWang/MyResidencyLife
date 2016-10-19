//
//  SurveyAppPageViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 8/29/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit


class SurveyAppPageViewController: UIPageViewController {

    
    
    //delegate for the page control.
    weak var controlDelegate: SurveyAppPageControlleDelegate?
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : AnyObject]?) {
        super.init(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    lazy var orderedViewControllers: [UIViewController] = {
        let resultPage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("ResultPageViewController") as! ResultPageViewController
        resultPage.setParentController(self)
        let firstPage = self.newIndexViewController("First") as! FirstQuestionPageController
        firstPage.setParentController(self)
        let secondPage = self.newIndexViewController("Second") as! SecondQuestionPageController
        secondPage.setParentController(self)
        let thirdPage = self.newIndexViewController("Third") as! ThirdQuestionPageController
        thirdPage.setParentController(self)
        //print("Here initialized feedback")
        return [secondPage,
            firstPage,
            thirdPage,
            resultPage,
        ]
    }()
    
    
    var feedbackPage: FeedbackViewController?
    var touched = false
    
    private func newIndexViewController(index: String)-> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewControllerWithIdentifier("\(index)ViewController")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.dataSource = self
        self.delegate = self
        
        print("Here initialized feedback")
        feedbackPage = self.newIndexViewController("Feedback") as! FeedbackViewController
        feedbackPage!.setParentController(self)
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                direction: .Forward,
                animated: true,
                completion: nil)
        }
        controlDelegate?.surveyAppPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }
    internal func collectResponse()->[String: String] {
        let email = NSUserDefaults.standardUserDefaults().stringForKey("ID")
        let response = [String: String]();
        let answerPage1 = (orderedViewControllers[1] as! FirstQuestionPageController).collectResponse() as [Int: (Int, Int)]
        let answerPage2 = (orderedViewControllers[0] as! SecondQuestionPageController).collectResponse()
        let answerPage3 = (orderedViewControllers[2] as! ThirdQuestionPageController).collectResponse() as [Int: (Int, Int)]
        
        
        print(answerPage1)
        print(answerPage2)
        print(answerPage3)
        print(feedbackPage?.getLength())
        
        let timeStamp = NSDate().timeIntervalSince1970
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let client = delegate.client!
        let answer_burnedout = Int(answerPage2["I\'m burned out"]!)!
        let answer_feel = Int(answerPage2["Today I feel"]!)!
        
        let item = ["timestamp": String(timeStamp), "burnout": answer_burnedout, "feel": answer_feel, "status": answerPage2["I\'m"]!, "email": email!]
        let itemTable1 = client.tableWithName("InputItem")
        itemTable1.insert(item as [NSObject : AnyObject]) {
            (insertedItem, error) in
            if (error != nil) {
                print("Error" + error!.description);
            } else {
                print("Item inserted");
            }
        }
        
        let itemTable2 = client.tableWithName("QuestionItem")
        let question_ans = ["timestamp": String(timeStamp), "Q1no": answerPage1[1]!.1, "Q1ans": answerPage1[1]!.0, "Q2no": answerPage1[2]!.1, "Q2ans": answerPage1[2]!.0, "Q3no": answerPage1[3]!.1, "Q3ans": answerPage1[3]!.0, "email": email!]

        itemTable2.insert(question_ans as [NSObject : AnyObject]) {
            (insertedItem, error) in
            if (error != nil) {
                print("Error" + error!.description);
            } else {
                print("Item inserted");
            }
        }
        
        
        let itemTable3 = client.tableWithName("MoreItem")
        let length = (feedbackPage?.getLength())! as Int
        let question_ans_add = ["timestamp": String(timeStamp), "Q1no": answerPage3[1]!.1, "Q1ans": answerPage3[1]!.0, "Q2no": answerPage3[2]!.1, "Q2ans": answerPage3[2]!.0, "email": email!, "textlength": length, "linkclicked": touched]
        touched = false
        itemTable3.insert(question_ans_add as [NSObject : AnyObject]) {
            (insertedItem, error) in
            if (error != nil) {
                print("Error" + error!.description);
            } else {
                print("Item inserted");
            }
        }
        return response
    }
    
    private func printResult(map:[String: String]) {
        for (index, answer) in map {
            print("index is: " + index + "answer is: " + answer)
        }
    }
    
    func goNextPage(_:AnyObject) {
        let cur = self.viewControllers![0]
        let p = self.pageViewController(self, viewControllerAfterViewController: cur)
        self.setViewControllers([p!], direction: .Forward, animated: true, completion: nil)
        let viewControllerIndex = orderedViewControllers.indexOf(p!)
        controlDelegate?.surveyAppPageViewController(self, didUpdatePageIndex: viewControllerIndex!)
        
        //print(viewControllerIndex)
        
    }
    func goPrevPage(_:AnyObject) {
        let cur = self.viewControllers![0]
        let p = self.pageViewController(self, viewControllerBeforeViewController: cur)
        self.setViewControllers([p!], direction: .Reverse, animated: true, completion: nil)
        let viewControllerIndex = orderedViewControllers.indexOf(p!)
        controlDelegate?.surveyAppPageViewController(self, didUpdatePageIndex: viewControllerIndex!)
    }
    
    func showFeedbackPage() {
        self.showViewController(feedbackPage!, sender: self)
    }
    
//    func testPage() {
//        feedbackPage.test();
//    }
    
}

extension SurveyAppPageViewController: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {return nil}
        guard orderedViewControllersCount > nextIndex else {return nil}
        return orderedViewControllers[nextIndex]
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        //return nil if a check does no pass.
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1;
        guard previousIndex >= 0 else{return nil}
        guard orderedViewControllers.count > previousIndex else {return nil}
        return orderedViewControllers[previousIndex];
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}

extension SurveyAppPageViewController: UIPageViewControllerDelegate {

    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.indexOf(firstViewController) {
                
                controlDelegate?.surveyAppPageViewController(self, didUpdatePageIndex: index)
        }
    }
}

protocol SurveyAppPageControlleDelegate: class {
    
    func surveyAppPageViewController(surveAppPageViewController: SurveyAppPageViewController,
        didUpdatePageCount count: Int)
    
    func surveyAppPageViewController(surveAppPageViewController: SurveyAppPageViewController,
        didUpdatePageIndex index: Int)
}




