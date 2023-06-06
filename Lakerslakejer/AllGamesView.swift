////
////  AllMatchesView.swift
////  Lakerslakejer
////
////  Created by Julia Petersson  on 2023-06-01.
////
//

//
//  AllMatchesView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-06-01.
//

import SwiftUI
import Combine

struct GameOverview: Codable {
    let gameID: Int
    let gameUUID: String
    let season: String
    let series: String
    let gameType: String
    let roundNumber: Int
    let startDateTime: Date
    let homeTeamCode: String
    let homeTeamResult: Int
    let awayTeamCode: String
    let awayTeamResult: Int
    let periodResults: String
    let gameCenterActive: Bool
    let played: Bool
    let overtime: Bool
    let penaltyShots: Bool
    let ticketURL: String
    let gameCenterURLDesktop: String
    let gameCenterURLMobile: String
    let tvChannels: [String]
    let venue: String
    
    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case gameUUID = "game_uuid"
        case season
        case series
        case gameType = "game_type"
        case roundNumber = "round_number"
        case startDateTime = "start_date_time"
        case homeTeamCode = "home_team_code"
        case homeTeamResult = "home_team_result"
        case awayTeamCode = "away_team_code"
        case awayTeamResult = "away_team_result"
        case periodResults = "period_results"
        case gameCenterActive = "game_center_active"
        case played
        case overtime
        case penaltyShots = "penalty_shots"
        case ticketURL = "ticket_url"
        case gameCenterURLDesktop = "game_center_url_desktop"
        case gameCenterURLMobile = "game_center_url_mobile"
        case tvChannels = "tv_channels"
        case venue
    }
}


class APIManager: ObservableObject {
    @Published var games: [GameOverview] = []
    private var cancellable: AnyCancellable?

    func fetchGames() {
        let urlString = "https://openapi.shl.se/seasons/2023/games.json?teamIds%5B%5D="
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [GameOverview].self, decoder: JSONDecoder()) // Update the decoding type to [GameOverview].self
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] games in
                self?.games = games
            })
    }
}







struct AllGamesView: View {
    
    @StateObject private var apiManager = APIManager()

        var body: some View {
            VStack {
                if apiManager.games.isEmpty {
                    Text("Loading...")
                } else {
                    List(apiManager.games, id: \.gameID) { game in
                        // Display game details
                        // Example:
                        Text(game.homeTeamCode)
                    }
                }
            }
            .onAppear {
                apiManager.fetchGames()
            }
        }
    }

struct AllMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        AllGamesView()
    }
}















