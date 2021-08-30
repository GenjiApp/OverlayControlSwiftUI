//
//  OverlayControlContainer.swift
//  OverlayControlSwiftUI
//
//  Created by Genji on 2021/08/30.
//

import SwiftUI

struct OverlayControlContainer<Content: View, OverlayControl: View>: View {

  @Binding var isEditing: Bool
  @ViewBuilder let content: Content
  @ViewBuilder let overlayControl: OverlayControl
  @State private var isHover = true
  @State private var timer: Timer? = nil

  var body: some View {
    ZStack {
      self.content
      VStack {
        Spacer()
        self.overlayControl
          .padding()
          .background(
            Capsule()
              .fill(Color(.windowBackgroundColor))
              .shadow(radius: 5)
          )
          .onHover { hovering in
            self.timer?.invalidate()
            self.timer = nil
            withAnimation {
              self.isHover = hovering
            }
          }
      }
      .padding(.bottom, 16)
      .opacity(self.isHover || self.isEditing ? 1.0 : 0.0)
    }
    .onAppear {
      self.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
        withAnimation {
          self.isHover = false
        }
        self.timer?.invalidate()
        self.timer = nil
      }
    }
  }
}

struct OverlayControlContainer_Previews: PreviewProvider {
  static var previews: some View {
    OverlayControlContainer(isEditing: .constant(false), content: {
      Image(systemName: "star")
        .font(.system(size: 500))
    }, overlayControl: {
      Slider(value: .constant(0.5), in: 0...1) {
        Text("Slider:")
      }
      .frame(width: 250)
    })
  }
}
