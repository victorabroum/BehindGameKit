import Foundation
import SpriteKit
import AVFoundation

public class SoundController {
    
    public static let shared: SoundController = .init()
    private weak var scene: SKScene?
    private var soundFXNode: SKAudioNode
    
    var backgroundMusicPlayer: AVAudioPlayer?
    
    
    private init() {
        soundFXNode = SKAudioNode()
    }
    
    public func setup(scene: SKScene) {
        self.scene = scene
        if soundFXNode.parent != nil {
            soundFXNode.move(toParent: scene)
        } else {        
            scene.addChild(soundFXNode)
        }
    }
    
    public func playMusic(named musicName: String, withExtension: String = "wav") {
        if let musicURL = Bundle.main.url(forResource: musicName, withExtension: withExtension) {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // Reproduzir indefinidamente
                backgroundMusicPlayer?.play()
            } catch {
                print("Erro ao carregar o arquivo de música de fundo: \(error)")
            }
        } else {
            print("Arquivo de música de fundo não encontrado.")
        }
    }
    
    public func stopMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    public func fadeInMusic(duration: TimeInterval) {
        backgroundMusicPlayer?.setVolume(1, fadeDuration: duration)
    }
    
    public func fadeOutMusic(duration: TimeInterval) {
        backgroundMusicPlayer?.setVolume(0, fadeDuration: duration)
    }
    
    public func changeVolume(to amount: Float, fadeDuration: TimeInterval = 0) {
        backgroundMusicPlayer?.setVolume(amount, fadeDuration: fadeDuration)
    }
    
    public func playSoundFX(named: String) {
        soundFXNode.run(.playSoundFileNamed(named, waitForCompletion: false))
    }
    
}
