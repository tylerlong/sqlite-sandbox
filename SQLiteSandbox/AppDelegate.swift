//
//  AppDelegate.swift
//  SQLiteSandbox
//
//  Created by Tyler Long on 2/15/16.
//  Copyright © 2016 Tylingsoft. All rights reserved.
//

import Cocoa
import SQLite

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var db: Connection?

    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func choose(sender: AnyObject) {
        let savePanel = NSSavePanel()
        let result = savePanel.runModal()
        if result == NSFileHandlingPanelCancelButton {
            return
        }
        db = try? Connection(savePanel.URL!.path!)
        let alert = NSAlert()
        if db != nil {
            alert.messageText = "db created successfully"
        } else {
            alert.messageText = "failed to create db"
        }
        alert.runModal()
    }

    @IBAction func save(sender: AnyObject) {
        createTable()
        insertData()
    }
    
    func createTable() {
        try! db!.execute("create table if not exists test (id integer, content text)")
    }
    
    func insertData() {
        let stmt = try! db!.prepare("INSERT INTO test (id, content) VALUES (?, ?)")
        try! stmt.run(1, "hello world")
    }

}
