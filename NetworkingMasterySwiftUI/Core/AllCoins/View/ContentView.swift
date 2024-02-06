//
//  ContentView.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 04.01.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = CoinsViewModel()
    
    var body: some View {
        VStack {
            if let errorMessage = vm.errorMessage {
                Text(errorMessage)
            } else {
                Text("\(vm.coin): \(vm.price)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
