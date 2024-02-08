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
        List {
            ForEach(vm.coins) { coin in
                Text(coin.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
