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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    
    let defaults = UserDefaults.standard
    
    //Uncomment this line in order to debug the onboarding
//    defaults.set(nil, forKey: "isFirstTime")
    
    if defaults.object(forKey: "isFirstTime") == nil{
        defaults.set(false, forKey:"isFirstTime")
        let storyboard = UIStoryboard(name: "Onboarding", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PageViewInitialController") as! OnboardingPageViewController
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
    }
    return true
  }
}
