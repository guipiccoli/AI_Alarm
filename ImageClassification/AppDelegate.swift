// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import UIKit
import NotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    public static var audioPlayer = AudioPlayer()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil ) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // Database.reset()
            
            /// Uncomment this line in order to debug the onboarding
            // Database.updateIsFirstTime(nil)
            /// ------------------------------------------------
            
        guard let window = self.window else { return true }
        
        if Database.getIsFirstTime() {
            
            Database.updateIsFirstTime(false)
            
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PageViewInitialController") as! OnboardingPageViewController
            window.rootViewController = viewController
            
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.5

            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
            
        else {
            
            let storyboard = UIStoryboard(name: "Alarms", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AlarmsNavigationController") as! UINavigationController
            window.rootViewController = viewController

            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.5

            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
        
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func startAlarm() {
        
        guard let window = self.window else { return }
        
        AppDelegate.audioPlayer.playAlarmSound()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "mainCameraScreen") as! ViewController
        viewController.isRegisteringObject  = false
        window.rootViewController = viewController
        
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.5

        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        self.window?.makeKeyAndVisible()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        startAlarm()
        
        completionHandler() /// must be called
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        startAlarm()
        
        completionHandler([.alert, .badge, .sound])
    }

}

