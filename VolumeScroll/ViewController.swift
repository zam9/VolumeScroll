//
//  ViewController.swift
//  VolumeScroll
//
//  Created by Zam on 06.09.2022.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var volumeSlider: NSSlider!
    
    var volumeLevel: UInt8 = 0
    var error: NSDictionary?
    
//    let scriptVolumeUp = """
//        set Outputvol to output volume of (get volume settings)
//        set volume output volume (Outputvol + 5)
//        """
//
//    let scriptVolumeDown = """
//        set Outputvol to output volume of (get volume settings)
//        set volume output volume (Outputvol - 5)
//        """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.init(red: 0, green: 0, blue: 0.1, alpha: 1).cgColor
        
//        volumeSlider.trackFillColor = NSColor.init(red: 0, green: 100, blue: 100, alpha: 1)
        
        let colorFilter = CIFilter(name: "CIFalseColor")!
//        colorFilter.setDefaults()
//        colorFilter.setValue(CIColor(cgColor: NSColor.white.cgColor), forKey: "inputColor0")
        colorFilter.setValue(CIColor(cgColor: NSColor.init(red: 0.1, green: 0.15, blue: 0.25, alpha: 1).cgColor), forKey: "inputColor1")
        volumeSlider.contentFilters = [colorFilter]
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func volumeSliderClick(_ sender: NSSlider) {
        volumeLevel = UInt8(volumeSlider.floatValue)
        
        let scriptVolumeSet = """
            set volume output volume \(volumeLevel)
        """
        
        run(scriptVolumeSet)
    }
    
    func run(_ source: String) {
        if let script = NSAppleScript(source: source) {
            script.executeAndReturnError(&error)
        }
    }
}


// This class is from https://github.com/thompsonate/Scrollable-NSSlider

class ScrollableSlider: NSSlider {
    override func scrollWheel(with event: NSEvent) {
        guard self.isEnabled else { return }
        
        let range = Float(self.maxValue - self.minValue)
        var delta = Float(0)
        
        // Allow horizontal scrolling on horizontal and circular sliders
        if _isVertical && self.sliderType == .linear {
            delta = Float(event.deltaY)
        } else if self.userInterfaceLayoutDirection == .rightToLeft {
            delta = Float(event.deltaY + event.deltaX)
        } else {
            delta = Float(event.deltaY - event.deltaX)
        }
        
        // Account for natural scrolling
        if event.isDirectionInvertedFromDevice {
            delta *= -1
        }
        
        let increment = range * delta / 300
        var value = self.floatValue + increment
        
        // Wrap around if slider is circular
        if self.sliderType == .circular {
            let minValue = Float(self.minValue)
            let maxValue = Float(self.maxValue)
            
            if value < minValue {
                value = maxValue - abs(increment)
            } else if value > maxValue {
                value = minValue + abs(increment)
            }
        }
        
        self.floatValue = value
        self.sendAction(self.action, to: self.target)
    }
    
    
    private var _isVertical: Bool {
        if #available(macOS 10.12, *) {
            return self.isVertical
        } else {
            // isVertical is an NSInteger in versions before 10.12
            return self.value(forKey: "isVertical") as! NSInteger == 1
        }
    }
}
