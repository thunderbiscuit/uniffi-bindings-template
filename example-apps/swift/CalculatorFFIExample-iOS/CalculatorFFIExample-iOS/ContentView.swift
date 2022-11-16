//
//  ContentView.swift
//  CalculatorFFIExample-iOS
//
//  Created by Steven Myers on 11/18/22.
//

import SwiftUI
import Calculator

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            let calcSize = CalculatorSize.small
            let calcData = CalculatorData(model: "test", size: calcSize)
            let calc = Calculator(info: calcData)
            let two = calc.add(a: 1, b: 1)
            Text("1 + 1 = " + String(two))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
