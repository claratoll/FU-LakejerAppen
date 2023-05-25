//
//  ProspectsView.swift
//  Lakerslakejer
//
//  Created by Clara Toll on 2023-05-24.
//


import CodeScanner
import SwiftUI
import UserNotifications

struct ScannedMembersView: View {
    /*enum FilterType {
        case none, contacted, uncontacted
    }*/

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false

   // let filter: FilterType

    var body: some View {
        NavigationView {
            List {
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
    }

    var title: String = "Scanned members"

    var filteredProspects: [Prospect] {return prospects.memberArray}

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let member = Prospect()
            member.memberNumber = details[0]
            member.couponNumber = details[1]
            prospects.add(member)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
}


struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ScannedMembersView()
            .environmentObject(Prospects())
    }
}
