//
//  OnboardingPageViewController.swift
//  ImageClassification
//
//  Created by Rafael Ferreira on 05/05/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var orderedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        orderedViewControllers = [self.initializeViewController(storyboardID: "OnboardingPage1"),
                                  self.initializeViewController(storyboardID: "OnboardingPage2")]
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func initializeViewController(storyboardID: String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: storyboardID)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    // Page before the one the user is currently on
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // Index of the current page
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            print("NAS QUE PORRA")
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // Making sure there is a page before the current one, and in case there isnt, returns nil
        guard previousIndex >= 0 else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    // Page after the one the user is currently on
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        
        //Index of the current page
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            print("mas que cu")
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return orderedViewControllers.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        guard let firstViewController = viewControllers?.first,
//            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController) else {
//                return 0
//        }
//        
//        return firstViewControllerIndex
//    }
}
