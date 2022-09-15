//
//  ContentView.swift
//  VolumeScroll
//
//  Created by Zam on 06.09.2022.
//
// Got from https://github.com/charlielevine/MacOSMenuBarWeatherApp
import SwiftUI

struct ContentView: View {
    var body: some View {
   //     Text("Hello, World!").frame(maxWidth: .infinity, maxHeight: .infinity)
        Button("Quit VolumeScroll") {
            NSApplication.shared.terminate(self)
        }
        .font(Font.custom("Avenir", size: 18))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .buttonStyle(.borderless)
        .tint(.black)
        //.background(Color.white)
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
