//
//  WheelPicker.swift
//  WheelPicker
//
//  Created by Dipin Ganesh on 01/07/2024.
//

import SwiftUI

struct WheelPicker: View {
    //Config
    @ObservedObject var config : Config
    @Binding var value :CGFloat
    
    //View properties
    @State var isLoaded : Bool = false
    var onSelectionChange: ((CGFloat) -> Void)?
    var body: some View {
        GeometryReader
        {
            let size = $0.size
            let horizontalPadding = size.width / 2
            
            ScrollView(.horizontal)
            {
                HStack(spacing: config.spacing){
                    let totalSteps = config.steps * config.count
                    
                    ForEach(0...totalSteps, id: \.self){ index in
                        let reminder = index % config.steps
                        
                        Divider()
                            .background(reminder  == 0 ? Color.primary : .gray)
                            .frame(width: 0, height: reminder == 0 ? size.height/3 : size.height/6, alignment: .center)
                            .frame(maxHeight: size.height/3, alignment : .bottom)
                            .overlay(alignment: .bottom)
                            {
                                if reminder == 0 && config.showText == true{
                                    Text("\((index / config.steps) * config.multipler)")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .textScale(.secondary)
                                        .fixedSize()
                                        .offset(y : size.height/3)
                                }
                            }
                    }
                }
                .frame(height: size.height)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                return isLoaded ? (Int(value) * config.steps) / config.multipler : 0
            }, set: { newValue in
                if let newValue {
                    value = (CGFloat(newValue) / CGFloat(config.steps)) * CGFloat(config.multipler)
                }
            }))
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: size.height * 2/3)
                    .padding(.bottom, size.height/3)
            })
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear{
                if !isLoaded  {
                    isLoaded = true
                }
            }
            .onChange(of: value) { newValue in
                    onSelectionChange?(newValue)
            }
        }
    }
    
    
}


#Preview {
    WheelPickerContainer(config: .init())
}
