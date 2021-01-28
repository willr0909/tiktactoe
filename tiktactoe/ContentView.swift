//
//  ContentView.swift
//  tiktactoe
//
//  Created by P.M. Student on 1/26/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            Home()
                .navigationTitle("Tic Tac Toe")
                .preferredColorScheme(.dark)
        }
    }
}

struct Home : View {
    
    // for the number of moves
    @State var moves : [String] = Array(repeating: "", count: 9)
            // identifies the current player
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
    
        
    var body: some View {
        VStack {
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 3), spacing: 15) {
                
                ForEach(0..<9, id: \.self) { index in
                    
                    ZStack {
                        Color.black
                        
                        Color.red
                            .opacity(moves[index] == "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            
                    }
                    
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(27)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)) {
                            
                            if moves[index] == "" {
                            moves[index] = isPlaying ? "🅇" : "🄾"
                                isPlaying.toggle()
                            }
                        }
                    })
                    
                }
            }
            
            .padding(15)
            
        }
        
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play Again"), action: {
                
                withAnimation(Animation .easeIn(duration: 0.5)) {
                    
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                    
                }
            }))
        })
        
    }
    
    // Used to calculate width
    
    func getWidth() -> CGFloat {
        let width = UIScreen.main.bounds.width - (30 + 30)
        
        return width / 3
    }
    
    func checkWinner(){
        
        if checkMoves(player: "🅇") {
            
            msg = "Player 🅇 Won!!!"
            gameOver.toggle()
        }
        
        if checkMoves(player: "🄾") {
            
            msg = " Player 🄾 Won!!!"
            gameOver.toggle()
        }
    }
    
    func checkMoves (player: String) -> Bool {
    //Check for horizontal moves
        for contestant in stride(from: 0, to: 9, by: 3) {
            if moves[contestant] == player && moves[contestant+1] == player && moves[contestant+2] == player {
                
                return true
            }
        }
        //Check for vertical moves
        for contestant in 0...2 {
            if moves[contestant] == player && moves[contestant+3] == player && moves[contestant+6] == player {
                
                return true
            }
        }
        //Check for diaonal moves
        if moves[0] == player && moves[4] == player && moves[8] == player {
           
            return true
        }
        // for other diagonal moves
        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        return false
    }
        
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }

}
