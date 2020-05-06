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
        
        Database.reset()
            
            /// Uncomment this line in order to debug the onboarding
            // Database.updateIsFirstTime(nil)
            /// ------------------------------------------------
            
        if Database.getIsFirstTime() {
            
            Database.updateIsFirstTime(false)
            
            let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "PageViewInitialController") as! OnboardingPageViewController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        else {
            
            let storyboard = UIStoryboard(name: "Alarms", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "AlarmsNavigationController") as! UINavigationController
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        AppDelegate.audioPlayer.playAlarmSound()
                
        NotificationHelper.removePendingAlarms(for: response.notification.request.content.categoryIdentifier)
        
        // TO-DO: - Open object recognizer screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "mainCameraScreen") as! ViewController
        viewController.isRegisteringObject  = false
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        completionHandler() /// must be called
    }
}

