//
//  SwiftUIView.swift
//  WheelPicker
//
//  Created by Dipin Ganesh on 01/07/2024.
//

import SwiftUI

struct WheelPickerContainer: View {
    @ObservedObject public var config : Config
    @State public var value :CGFloat = 5
    
    var onValueChange: ((CGFloat) -> Void)?
    var body: some View {
        GeometryReader
        {
            let size = $0.size
            VStack{
                HStack(alignment: .lastTextBaseline, spacing: 5, content: {
                    Text(verbatim: "\(value)")
                        .font(.system(size: size.height/2.5, weight: .bold))
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                    
                    Text("\(config.unit)")
                        .font(.system(size: size.height/4))
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                        
                })
                .frame(height: size.height/3)
                
                WheelPicker(config: config, value: $value){ newValue in
                    if (onValueChange != nil)
                    {
                        onValueChange!(newValue)
                    }
                }
                .frame(height: size.height * 2/3)
            }
            .navigationTitle("Wheel Picker")
            
        }
    }
}

#Preview {
    WheelPickerContainer(config: .init())
}
