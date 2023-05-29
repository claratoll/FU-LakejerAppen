//
//  ProspectsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import CodeScanner
import SwiftUI
import UserNotifications

struct ScannedView: View {
    @StateObject var scanVM = ScanVM()

    @EnvironmentObject var members: Members
    @State private var isShowingScanner = false

   // let filter: FilterType

    var body: some View {
        NavigationView {
            List {
                ForEach(scanVM.games) { game in
                    Text(game.awayName)
                    Text(game.awayDate.description)
                }
                
                
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.memberNumber)
                            .font(.headline)
                        Text(prospect.couponNumber)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle(title)
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

    var title: String = "Scanned members"

    var filteredProspects: [Scan] {return members.memberArray}

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            var member = Scan()
            member.memberNumber = details[0]
            member.couponNumber = details[1]
            var memberNr = details[0]
            
            
            scanVM.saveMemberToFirebase(name: "clara", memberNr: Int(memberNr) ?? 0000)
            
            members.add(member)
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

