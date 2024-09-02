# Game Center

A helper to handle GameCenter facilitating user authentication and saving the best score.

## Getting started

We should call authentication game center from the very begin of your app. Like in the first viewDidLoad and implement **GKGameCenterControllerDelegate** protocol on the class.
Don't fogert to import **BehindGameKit**

```swift
import BehindGameKit

// ...

class GameViewController: UIViewController, GKGameCenterControllerDelegate { 
    // ...
    override func viewDidLoad() {
        // ...
        GameCenter.shared.authenticateLocalPlayer(presentingViewController: self)
    }
    // ...
}
```

Than if you just leading with one Leader board you can pass the board ID to the GameCenter class to easy future acess.

```swift
override func viewDidLoad() {
    // ...
    GameCenter.shared.setLeaderBoardID("your_id_goes_here")
}
```
