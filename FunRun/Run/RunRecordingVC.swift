import Foundation
import SwiftUI

class RunRecordingVC: UIHostingController<RunRecordingView> {
    init() {
        super.init(rootView: RunRecordingView())
    }

    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
