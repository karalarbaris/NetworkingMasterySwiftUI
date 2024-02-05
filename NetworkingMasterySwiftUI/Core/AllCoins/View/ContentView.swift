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
            Text("\(vm.coin): \(vm.price)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
