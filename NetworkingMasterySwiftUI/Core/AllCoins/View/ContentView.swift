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
                HStack(spacing: 12) {
                    Text("\(coin.marketCapRank)")
                        .foregroundStyle(Color.gray)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.name)
                            .fontWeight(.semibold)
                        Text(coin.symbol.uppercased())
                            
                    }
                }
                .font(.footnote)
            }
        }
        .overlay {
            if let error = vm.errorMessage {
                Text(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
