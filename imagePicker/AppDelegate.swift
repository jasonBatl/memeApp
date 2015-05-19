    //
//  AppDelegate.swift
//  imagePicker
//
//  Created by Bronson, Jason on 4/6/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var memes = [Meme]()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if self.memes.count == 0 {
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! UIViewController
        
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }else{
            var initialViewController = storyboard.instantiateViewControllerWithIdentifier("SentMemesTableViewController") as! SentMemesTableViewController
            
            self.window?.rootViewController = initialViewController
        }
        
        return true
    }

  
}

