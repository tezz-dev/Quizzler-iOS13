//
//  LinearProgressView.swift
//  CustomLinearProgressView
//
//  Created by tezz on 23/02/21.
//

import SwiftUI

//struct LPVwithButton: View {
//    @State var progress = 0.0
//    var body: some View {
//        VStack {
//            LinearProgressView(progress: $progress)
//            Button(action: {
//                progress += 0.1
//            }) {
//                Text("Button")
//                    .background(Color.green)
//            }
//        }
//    }
//}

struct LinearProgressView: View {
    @State var width = UIScreen.main.bounds.width * 0.7
    @State var height = UIScreen.main.bounds.height * 0.7
    @State var color = Color.red
    @State var progress: Double
    
    var notificationChanged = NotificationCenter.default.publisher(for: .progress)
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    ZStack {
                        VStack {
                            Rectangle()
                                .frame(width: width * 0.8, height: 20)
                                .cornerRadius(20)
                                .foregroundColor(.white)
                        }
                        .frame(width: width * 0.8, height: 20, alignment: .leading)
                        VStack {
                            Rectangle()
                                .trim(from: 0.0, to: 0.459 * CGFloat(min(self.progress, 1.0)))
                                .stroke(Color.red, lineWidth: 40)
                                .animation(.linear)
                                .frame(width: (width * 0.8), height: 20)
                                .cornerRadius(20)
                                .foregroundColor(color)
                                .onReceive(notificationChanged) { note in
                                    self.progress = note.userInfo!["progress"]! as! Double
                                }
                        }.frame(width: width * 0.8, height: 20, alignment: .leading)
                    }.frame(width: width * 0.8, height: 30, alignment: .leading)
                }
                .background(Color.white.opacity(0.0))
                .shadow(color: .white, radius: 2, x: 0.0, y: 0.0)
                
                VStack {
                    if progress <= 0.099 {
                        HStack(spacing: 0.0) {
                            StrokeText(text: "00", width: 1.5, color: .black)
                                .font(.custom("AvenirNext-Bold", size: 16.0))
                                .foregroundColor(.white)
                                .opacity(0.0)
                            StrokeText(text: String(format: "%.0f%%", min(self.progress, 1.0)*100.0), width: 1.5, color: .black)
                                .font(.custom("AvenirNext-Bold", size: 16.0))
                                .foregroundColor(.white)
                        }
                    }
                    else if progress <= 0.999 {
                        HStack(spacing: 0.0) {
                            StrokeText(text: "0", width: 1.5, color: .black)
                                .font(.custom("AvenirNext-Bold", size: 16.0))
                                .foregroundColor(.white)
                                .opacity(0.0)
                            StrokeText(text: String(format: "%.0f%%", min(self.progress, 1.0)*100.0), width: 1.5, color: .black)
                                .font(.custom("AvenirNext-Bold", size: 16.0))
                                .foregroundColor(.white)
                        }
                    }
                    else {
                        HStack(spacing: 0.0) {
                            StrokeText(text: String(format: "%.0f%%", min(self.progress, 1.0)*100.0), width: 1.5, color: .black)
                                .font(.custom("AvenirNext-Bold", size: 15.0))
                                .foregroundColor(.white)
                        }
                    }
                }
                .background(Color.green.opacity(0.0))
            }
        }
        .background(Color.green.opacity(0.0))
    }
}

struct StrokeText: View {
    let text: String
    let width: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

//struct LinearProgressViewPreviewProvider: PreviewProvider {
//    static var previews: some View {
//        LPVwithButton()
//    }
//}
