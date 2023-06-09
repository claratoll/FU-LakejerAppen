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
    
    //visar först aktuella matcher och därefter vilka användare som är anmälda till varje specifik match
    
    //admin kan scanna användare som läggs till varje specifik match
    
    var body: some View {
        VStack {
            Text(game.awayName)
                .font(.title)
            Text(scanVM.formattedDate(game.awayDate))
                .font(.subheadline)
                .padding(.bottom, 20)
            
            ScrollView{
                ForEach(scanVM.bookedUser) { member in
                    Text("Member Number: \(member.memberNumber)")
                    Text("Booked: \(member.booked.description)")
                    Text("Scanned: \(member.scanned.description)")
                        .padding(.bottom, 20)
                }
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
            CodeScannerView(codeTypes: [.qr], simulatedData: "2222\n22", completion: handleScan)
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
            print(memberNumber)
            print(couponNumber)
            
            //om lyckad scan så läggs användaren till på firebase

            scanVM.saveMemberToFirebase(memberNr: Int(memberNumber) ?? 1111, couponNumber: Int(couponNumber) ?? 11, gameID: game.id ?? "", booked: true, scanned: true)
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ScannedView: View {
    @StateObject var scanVM = ScanVM()

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
            
    }
}

