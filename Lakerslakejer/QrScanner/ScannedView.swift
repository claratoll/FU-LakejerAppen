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
    @StateObject var scanVM = ScanVM()
    @State private var isShowingScanner = false
    
    var body: some View {
        VStack {
            Text(game.awayName)
                .font(.title)
            Text(scanVM.formattedDate(game.awayDate))
                .font(.subheadline)
                .padding(.bottom, 20)
            
            ForEach(scanVM.bookedUser) { member in
                Text("Member Number: \(member.memberNumber)")
                Text("Booked: \(member.booked.description)")
                Text("Scanned: \(member.scanned.description)")
                    .padding(.bottom, 20)
                
            }
            Spacer()
        }
        .navigationTitle("Scanned members")
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
        .onAppear{
            scanVM.fetchScannedMembers(gamesID: game.id ?? "")
            
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let memberNumber = details[0]
            let couponNumber = details[1]

            scanVM.saveMemberToFirebase(memberNr: Int(memberNumber) ?? 0000, couponNumber: Int(couponNumber) ?? 00, gameID: game.id ?? "")
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ScannedView: View {
    @StateObject var scanVM = ScanVM()

    @EnvironmentObject var members: Members
    

    var body: some View {
        NavigationView {
            List {
                ForEach(scanVM.games) { game in
                    NavigationLink(destination: GameDetailView(game: game)){
                        Text(game.awayName)
                        Text(scanVM.formattedDate(game.awayDate))
                    }
                }
                
            }
            .navigationTitle("Games")
            
        }
        .onAppear{
            scanVM.fetchGames()
        }
    }
}


struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedView(scanVM: ScanVM())
            .environmentObject(Members())
    }
}

