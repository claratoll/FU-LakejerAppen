//
//  AllMatchesView.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-06-01.
//

import SwiftUI
struct GameOverview: Codable
{
    let game_id : Int
    let series : String
    let start_date_time : Date
    let home_team_code : String
    let home_team_result: Int
    let away_team_result : Int
    let away_team_code : String
    let played : Bool
    

    
    
//        [
//          {
//            "game_id": 0,
//            "game_uuid": "string",
//            "season": "string",
//            "series": "string",
//            "game_type": "regular",
//            "round_number": 0,
//            "start_date_time": "2023-06-01T06:24:54.139Z",
//            "home_team_code": "string",
//            "home_team_result": 0,
//            "away_team_code": "string",
//            "away_team_result": 0,
//            "period_results": "string",
//            "game_center_active": true,
//            "played": true,
//            "overtime": true,
//            "penalty_shots": true,
//            "ticket_url": "string",
//            "game_center_url_desktop": "string",
//            "game_center_url_mobile": "string",
//            "tv_channels": [
//              "string"
//            ],
//            "venue": "string"
//          }
//        ]
    
    
}

class ViewModel: ObservableObject{
    
 
    
    
    
    func fetch(){
        guard let url = URL(string: "https://openapi.shl.se/seasons/2023/games.json") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, _, error in
            guard let data = data, error == nil else{
                return
            }
            
            //videon converta till json - men jag har ju jsn..
            
            
            
        }
        
    }
    
    
}


struct AllMatchesView: View {
    @State private var gameOverviews = [GameOverview]()
    
    var body: some View {
        
        NavigationView{
            List(gameOverviews, id: \.game_id) { gameOverview in
                VStack{
                    Text(gameOverview.series)
                    Text(gameOverview.home_team_code)
                    Text(gameOverview.away_team_code)
                }
            }
            .navigationTitle("Alla matchar")
            .task{
                await fetchData()
            }
            
            
            
        }
        
        
        
        
    }
    
    func createDataManually (){
        
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://openapi.shl.se/seasons/2022/games.json?teamIds%5B%5D="
        ) else{
            print("nope")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
          
            
            if let decodedResponse = try? JSONDecoder().decode([GameOverview].self, from: data)
            {
                
                gameOverviews = decodedResponse
                
            }
            
        } catch{
            
            print("nix")
            
        }
        
    }
}
struct AllMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        AllMatchesView()
    }
}
