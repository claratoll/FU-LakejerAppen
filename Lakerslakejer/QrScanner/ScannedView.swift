//
//  ProspectsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import CodeScanner
import SwiftUI
import UserNotifications

struct GameDetailView: View {
    let game: Game
    
    var body: some View {
        VStack {
            Text(game.awayName)
                .font(.title)
            Text(game.awayDate.description)
                .font(.subheadline)
            // Add more details or customize the view as needed
        }
        .navigationTitle("Scanned members")
    }
}


struct ScannedView: View {
    @StateObject var scanVM = ScanVM()

    @EnvironmentObject var members: Members
    @State private var isShowingScanner = false


    var body: some View {
        NavigationView {
            List {
                ForEach(scanVM.games) { game in
                    NavigationLink(destination: GameDetailView(game: game)){
                        Text(game.awayName)
                        Text(formattedDate(game.awayDate))
                    }
                }
                
            }
            .navigationTitle("Games")
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "0000\n0", completion: handleScan)
            }
        }
        .onAppear{
            scanVM.fetchGames()
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            var memberNumber = details[0]
            var couponNumber = details[1]

            scanVM.saveMemberToFirebase(memberNr: Int(memberNumber) ?? 0000, couponNumber: Int(couponNumber) ?? 00)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedView(scanVM: ScanVM())
            .environmentObject(Members())
    }
}

