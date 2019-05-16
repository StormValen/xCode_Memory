//
//  FirestoreRepository.swift
//  SimpleMemoryGame
//
//  Created by Valentin Gutierrez on 25/04/2019.
//  Copyright © 2019 p1xelP3rfect. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreService {
    let k_COLLECTION_SCORE = "score"
    let k_COLLECTION_APP_STATS = "app_stats"
    
    var easyGamesNumber: String = "Default"
    var mediumGamesNumber: String = "Default"
    var hardGamesNumber: String = "Default"
    
    let db = Firestore.firestore()
    
    func writeUserScore(score: Int, username: String?, userId: String) {
        // Si no existe la collection la crea, no pasa con los document.
        db.collection(k_COLLECTION_SCORE)
            .addDocument(data: ["score": score, "username": username ?? "", "userId": userId])
    }
    
    func updateUserScore(score: Int, username: String?, userId: String) {
        // Si el documento ya existe lo sobreescribe, si no lo crea.
        // [merge: true] sobreescribe la info que se le pasa y mantiene la que exista en otros campos.
        db.collection(k_COLLECTION_SCORE)
            .document(userId)
            .setData(["score": score, "username": username ?? "", "userId": userId])
    }
    
    func addGamePlayed(gameStats: [String], gameMode: GameMode) {
        var gStats = gameStats
        var statToAdd: Int = 0
        switch gameMode {
        case .EASY:
            statToAdd = Int(gameStats[0])!
            statToAdd += 1
            gStats = [String(statToAdd), gameStats[1], gameStats[2]]
            break;
        case .MEDIUM:
            statToAdd = Int(gameStats[1])!
            statToAdd += 1
            gStats = [gameStats[0], String(statToAdd), gameStats[2]]
            break;
        case .HARD:
            statToAdd = Int(gameStats[2])!
            statToAdd += 1
            gStats = [gameStats[0], gameStats[1], String(statToAdd)]
            break;
        }
        db.collection(k_COLLECTION_APP_STATS).document("games").setData(["easy": gStats[0], "medium": gStats[1], "hard": gStats[2]])
    }
    
    func readUserScore() {
        db.collection(k_COLLECTION_SCORE)
            .whereField("score", isGreaterThan: 0)
            .getDocuments {(snapshot, error) in
                
                //Es necesario un sistem de control de error.
                if let error = error {
                    print("Not connecting to DB with error: ", error)
                } else {
                    snapshot?.documents.forEach({ print($0.data()) })
                }
        }
    }
    
    func getGameStats(_ callback: @escaping (([String]) -> Void)) {
        
        var easy: String = ""
        var medium: String = ""
        var hard: String = ""
        
        db.collection(k_COLLECTION_APP_STATS).getDocuments() { (querySnapshot, err) in
            if let error = err {
                print("Error when accessing - ", self.k_COLLECTION_APP_STATS)
                print(error)
            } else {
                for doc in querySnapshot!.documents {
                    let gameStats = doc.data()
                    gameStats.forEach({
                        switch($0.key) {
                            case "easy":
                                easy.append("\(String(describing: $0.value))")
                                // self.easyGamesNumber = $0.value as! String
                                break;
                            case "medium":
                                medium.append("\(String(describing: $0.value))")
                                // self.mediumGamesNumber = $0.value as! String
                                break;
                            case "hard":
                                hard.append("\(String(describing: $0.value))")
                                // self.hardGamesNumber = $0.value as! String
                                break;
                            default:
                                break;
                        }
                    })
                }
                callback([easy, medium, hard])
            }
        }
    }
    
    func getGames(lvl: String) -> String {
        switch (lvl) {
        case "easy":
            return self.easyGamesNumber
        case "medium":
            return self.mediumGamesNumber
        case "hard":
            return self.hardGamesNumber
        default:
            return "hey"
        }
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(
            withEmail: email,
            password: password) { authResult, error in
                if error == nil && authResult != nil {
                    print("User created succesfully!")
                } else {
                    print("ERROR when creating new user")
                }
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn( withEmail: email, password: password) { user, error in
                if error == nil && user != nil {
                    print("LOGGED")
                } else {
                    print("ERROR when trying to sign in")
                }
        }
    }
}
