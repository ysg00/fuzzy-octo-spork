//
//  AppDelegate.swift
//  menubar
//
//  Created by Hang Yu on 1/2/23.
//

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {
    var menuBarItem: NSStatusItem!
    var capsLockStatus = false {
        didSet {
            // update the icon to reflect the caps lock status
            if capsLockStatus {
                menuBarItem.button?.image = NSImage(systemSymbolName: "star", accessibilityDescription: "star")
            } else {
                menuBarItem.button?.image = NSImage(systemSymbolName: "circle", accessibilityDescription: "circle")
            }
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
           // create the menu bar item
           menuBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        

           // set the initial icon based on the caps lock status
           let event = CGEvent(keyboardEventSource: nil, virtualKey: 0x39, keyDown: true)!
           capsLockStatus = event.flags.contains(.maskAlphaShift)
        // create a global event monitor to continuously monitor keyboard events
        NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged, handler: { (event) in
               // update the caps lock status when a caps lock key event is received
            self.capsLockStatus = event.modifierFlags.contains(.capsLock)
           })
        // create the menu
        let menu = NSMenu()

        // add a menu item to quit the app
        let quitItem = NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        menu.addItem(quitItem)

        // set the menu for the menu bar item
        menuBarItem.menu = menu
    }
}
