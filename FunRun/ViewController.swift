import UIKit
import SwiftUI

class ViewController: UIViewController {

    private let runRecordingVC = RunRecordingVC()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "FunRun"

        runRecordingVC.willMove(toParent: self)
        addChild(runRecordingVC)
        runRecordingVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(runRecordingVC.view)
        view.addConstraints([
            runRecordingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            runRecordingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            runRecordingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            runRecordingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        runRecordingVC.didMove(toParent: self)
    }
}
