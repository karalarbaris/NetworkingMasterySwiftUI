//
//  ContentView.swift
//  NetworkingMasterySwiftUI
//
//  Created by Baris Karalar on 04.01.24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    private let service: CoinServiceProtocol
    @StateObject var vm: CoinsViewModel
    
    init(service: CoinServiceProtocol) {
        self.service = service
        self._vm = StateObject(wrappedValue: CoinsViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.coins) { coin in
                    NavigationLink(value: coin) {
                        HStack(spacing: 12) {
                            Text("\(coin.marketCapRank)")
                                .foregroundStyle(Color.gray)
                            
                            KFImage(URL(string: coin.image))
                                .resizable()
                                .frame(width: 32, height: 32)
         
                            VStack(alignment: .leading, spacing: 4) {
                                Text(coin.name)
                                    .fontWeight(.semibold)
                                Text(coin.symbol.uppercased())
                                    
                            }
                        }
                        .onAppear {
                            if coin == vm.coins.last {
                                Task {
                                    await vm.fetchCoins()                                    
                                }
                            }
                        }
                        .font(.footnote)
                    }
                }
            }
            
            .navigationDestination(for: Coin.self, destination: { coin in
                CoinDetailsView(coin: coin, service: service)
            })
            .overlay {
                if let error = vm.errorMessage {
                    Text(error)
                }
            }
        }
        .task {
            await vm.fetchCoins()
        }
    }
}

#Preview {
    ContentView(service: MockCoinService())
}
