//
//  GameCenter.swift
//  
//
//  Created by Victor Vasconcelos on 06/03/20.
//

import Foundation
import GameKit

public class GameCenter {
    
    public static let shared = GameCenter()
    
    private init() { }
    
    private(set) var isGameCenterEnabled: Bool = false
    private(set) var leaderBoardID = ""
    private(set) var playerHighScore: Int64?
    
    public func setLeaderBoardID(_ id: String) {
        self.leaderBoardID = id
    }
    
    public func presentGCLeaderboard(from viewController: GKGameCenterControllerDelegate,
                                     withLeaderBoardID id: String? = nil) {
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = viewController
        gcVC.viewState = .leaderboards
        if id != nil {
            gcVC.leaderboardIdentifier = id!
        } else {
            gcVC.leaderboardIdentifier = self.leaderBoardID
        }
        if let vc = viewController as? UIViewController {
            vc.present(gcVC, animated: true, completion: nil)
        }
    }
    
    public func authenticateLocalPlayer(presentingViewController vc: UIViewController) {
        GKLocalPlayer.local.authenticateHandler = { [weak self] (gameViewController, error) in
            guard error == nil else {
                print(error ?? "Unable to authenticate local player")
                return
            }
            if let gameViewController = gameViewController {
                vc.present(gameViewController, animated: true, completion: nil)
            }
            self?.isGameCenterEnabled = GKLocalPlayer.local.isAuthenticated
        }
    }
    
    public func updateScore(onLeaderBoardID id: String? = nil, newScore value: Int) {
        if let highScore = self.playerHighScore {
            if highScore > value { return }
        }
        self.playerHighScore = Int64(value)
        let id = id == nil ? self.leaderBoardID : id!
        let score = GKScore(leaderboardIdentifier: id)
        score.value = Int64(value)
        GKScore.report([score]) { (error) in
            if let error = error {
                print("Error when try to push new score to board --- \(error)")
            }
        }
    }
    
    public func fectchHighScore(onLeaderBoardID id: String? = nil) {
        let id = id == nil ? self.leaderBoardID : id!
        if GKLocalPlayer.local.isAuthenticated {
            GKLeaderboard.loadLeaderboards { (leadBoards, error) in
                guard error == nil else {
                    print("Unable to fecth leadboards --- \(error!)")
                    return
                }
                guard let leadBoards = leadBoards else {
                    print("No leadboard found")
                    return
                }
                for leadBoard in leadBoards {
                    if leadBoard.identifier == id {
                        self.playerHighScore = leadBoard.localPlayerScore?.value
                    }
                }
            }
        }
    }
    
    public func getHighScore() -> Int {
        return Int(truncatingIfNeeded: self.playerHighScore ?? 0)
    }
}
