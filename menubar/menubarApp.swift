//
//  menubarApp.swift
//  menubar
//
//  Created by Hang Yu on 1/1/23.
//

import SwiftUI


@main
struct menubarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        Settings {}
    }
}

