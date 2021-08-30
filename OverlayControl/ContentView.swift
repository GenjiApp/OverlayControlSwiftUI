//
//  ContentView.swift
//  OverlayControl
//
//  Created by Genji on 2021/08/30.
//

import SwiftUI

struct ContentView: View {

  @State private var hue = 0.5
  @State private var isEditing = false

  var body: some View {
    VStack {
      OverlayControlContainer(isEditing: self.$isEditing, content: {
        Image(systemName: "star")
          .font(.system(size: 500))
          .foregroundColor(Color(hue: self.hue, saturation: 1.0, brightness: 1.0))
      }, overlayControl: {
        Slider(value: self.$hue, in: 0...1, onEditingChanged: { editing in
          withAnimation {
            self.isEditing = editing
          }
        }, label: {
          Text("Hue:")
        })
        .frame(width: 250)
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
