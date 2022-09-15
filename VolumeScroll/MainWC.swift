//
//  MainWC.swift
//  VolumeScroll
//
//  Created by Zam on 06.09.2022.
//

import Cocoa

class MainWC: NSWindowController {

    @IBOutlet weak var mainWindow: NSWindow!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    
        mainWindow.isMovableByWindowBackground = true
    }

}
