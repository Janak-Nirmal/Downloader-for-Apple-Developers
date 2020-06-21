//
//  AppDelegate.swift
//  DeveloperToolsDownloader
//
//  Created by Vineet Choudhary on 17/02/20.
//  Copyright © 2020 Developer Insider. All rights reserved.
//

import Cocoa
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationWillFinishLaunching(_ notification: Notification) {
        //CocoaLumberjack
        DLog.config()
        
        //App Center
        if let appCenter = Bundle.main.object(forInfoDictionaryKey: "AppCenter") as? String {
            MSAppCenter.start(appCenter, withServices:[MSAnalytics.self, MSCrashes.self])
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //Update Manager
        UpdateManager.shared.checkForUpdates { (updateURL) in
            UpdateManager.shared.showUpdateAlert(updateURL: updateURL)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        for downloadProcess in DownloadProcessManager.shared.downloadProcesses {
            downloadProcess.terminate()
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

}

