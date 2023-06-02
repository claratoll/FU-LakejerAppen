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



//
//
//class ViewModel: ObservableObject{
//
//
//
//
//
//    func fetch(){
//        guard let url = URL(string: "https://openapi.shl.se/seasons/2023/games.json") else{
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url){
//            data, _, error in
//            guard let data = data, error == nil else{
//                return
//            }
//
//            //videon converta till json - men jag har ju jsn..
//
//
//
//        }
//
//    }
//
//
//}



struct AllMatchesView: View {
    
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
        AllMatchesView()
    }
}















// Do not delete yet
//    @State private var gameOverviews = [GameOverview]()
//
//    var body: some View {
//
//        NavigationView{
//            List(gameOverviews, id: \.game_id) { gameOverview in
//                VStack{
//                    Text(gameOverview.series)
//                    Text(gameOverview.home_team_code)
//                    Text(gameOverview.away_team_code)
//                }
//            }
//            .navigationTitle("Alla matchar")
//            .task{
//                await fetchData()
//            }
//
//
//
//        }
//
//
//
//
//    }
//
//    func createDataManually (){
//
//    }
//
//    func fetchData() async {
//        guard let url = URL(string: "https://openapi.shl.se/seasons/2022/games.json?teamIds%5B%5D="
//        ) else{
//            print("nope")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//
//            if let decodedResponse = try? JSONDecoder().decode([GameOverview].self, from: data)
//            {
//
//                gameOverviews = decodedResponse
//
//            }
//
//        } catch{
//
//            print("nix")
//
//        }
//
//    }
//}



//import SwiftUI
//struct GameOverview: Codable
//{
//    let game_id : Int
//    let series : String
//    let start_date_time : Date
//    let home_team_code : String
//    let home_team_result: Int
//    let away_team_result : Int
//    let away_team_code : String
//    let played : Bool
//
//
//
//
////        [
////          {
////            "game_id": 0,
////            "game_uuid": "string",
////            "season": "string",
////            "series": "string",
////            "game_type": "regular",
////            "round_number": 0,
////            "start_date_time": "2023-06-01T06:24:54.139Z",
////            "home_team_code": "string",
////            "home_team_result": 0,
////            "away_team_code": "string",
////            "away_team_result": 0,
////            "period_results": "string",
////            "game_center_active": true,
////            "played": true,
////            "overtime": true,
////            "penalty_shots": true,
////            "ticket_url": "string",
////            "game_center_url_desktop": "string",
////            "game_center_url_mobile": "string",
////            "tv_channels": [
////              "string"
////            ],
////            "venue": "string"
////          }
////        ]
//
//
//}
//
//class ViewModel: ObservableObject{
//
//
//
//
//
//    func fetch(){
//        guard let url = URL(string: "https://openapi.shl.se/seasons/2023/games.json") else{
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url){
//            data, _, error in
//            guard let data = data, error == nil else{
//                return
//            }
//
//            //videon converta till json - men jag har ju jsn..
//
//
//
//        }
//
//    }
//
//
//}
//
//
//struct AllMatchesView: View {
//    @State private var gameOverviews = [GameOverview]()
//
//    var body: some View {
//
//        NavigationView{
//            List(gameOverviews, id: \.game_id) { gameOverview in
//                VStack{
//                    Text(gameOverview.series)
//                    Text(gameOverview.home_team_code)
//                    Text(gameOverview.away_team_code)
//                }
//            }
//            .navigationTitle("Alla matchar")
//            .task{
//                await fetchData()
//            }
//
//
//
//        }
//
//
//
//
//    }
//
//    func createDataManually (){
//
//    }
//
//    func fetchData() async {
//        guard let url = URL(string: "https://openapi.shl.se/seasons/2022/games.json?teamIds%5B%5D="
//        ) else{
//            print("nope")
//            return
//        }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//
//            if let decodedResponse = try? JSONDecoder().decode([GameOverview].self, from: data)
//            {
//
//                gameOverviews = decodedResponse
//
//            }
//
//        } catch{
//
//            print("nix")
//
//        }
//
//    }
//}
//struct AllMatchesView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMatchesView()
//    }
//}
