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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                if self.menuBarItem == nil {
//                    self.menuBarItem = NSStatusBar.system.statusItem(withLength: 10)
//                }
                if self.capsLockStatus {
                    self.menuBarItem.button?.image = NSImage(named: "caps-lock-on-24")
                } else {
                    self.menuBarItem.button?.image = NSImage(named: "caps-lock-off-24")
//                    NSStatusBar.system.removeStatusItem(self.menuBarItem)
//                    self.menuBarItem = nil
                }
            }
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // create the menu bar item
        menuBarItem = NSStatusBar.system.statusItem(withLength: 10)

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
        let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)

        let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
        let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)

        let loc = CGEventTapLocation.cghidEventTap

        cmdd?.post(tap: loc)
        cmdu?.post(tap: loc)
        
    }
    private func updateMenuBarIcon() {
        // update the icon to reflect the caps lock status
        if capsLockStatus {
            menuBarItem.button?.image = NSImage(named: "caps-lock-on-24")
        } else {
            menuBarItem.button?.image = NSImage(named: "caps-lock-off-24")
        }
    }
}
