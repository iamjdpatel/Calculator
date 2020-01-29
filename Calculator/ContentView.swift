//
//  ContentView.swift
//  Calculator
//
//  Created by JD Patel on 28/01/20.
//  Copyright © 2020 JD. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equal, plus, minus, multiply, divide
    case ac, plusMinus, percent
    case decimal
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six : return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine : return "9"
            
        case .equal: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "X"
        case .divide : return "/"
        case .plusMinus: return "+/-"
        case .percent: return "%"
            
        case .decimal: return "."
            
        default:
            return "C"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
}

class GlobalEnvironment: ObservableObject {
    
    @Published var display = "0"
    
    func receiveInput(calculatorButton: CalculatorButton) {
        switch calculatorButton {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            if self.display == "0" {
                self.display = calculatorButton.title
            } else {
                self.display += calculatorButton.title
            }
        case .ac:
            self.display = "0"
        case .plus, .minus, .multiply, .divide:
            break
        default:
            self.display = ""
        }
        
    }
    
}

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                HStack {
                    
                    Spacer()
                    Text(env.display)
                        .foregroundColor(.white)
                        .font(.system(size: 64))
                    
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    
                    HStack(spacing: 12) {
                        
                        ForEach(row, id: \.self) { button in
                            
                            CalculatorButtonView(button: button)
                            
                        }
                        
                    }
                    
                }
                
            }.padding(.bottom)
            
        }
        
    }
    
    
    
}

struct CalculatorButtonView: View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        
        Button(action: {
            
            self.env.receiveInput(calculatorButton: self.button)
            
        }) {
        
            Text(button.title)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonWidth(button: button))
            
        }
        
    }
    
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
