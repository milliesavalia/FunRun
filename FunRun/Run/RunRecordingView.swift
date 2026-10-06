import SwiftUI

struct RunRecordingView: View {
    @StateObject var viewModel: RunRecordingViewModel = RunRecordingViewModel()

    var body: some View {
        VStack(spacing: 20) {
            switch viewModel.recorderState {
            case .stopped:
                Text("Run Recorder: Stopped")
                    .font(.title)

                Button("Start Recording") {
                    viewModel.startRecording()
                }
                    .buttonStyle(.borderedProminent)

            case .recording:
                Text("Run Recorder: Recording")
                    .font(.title)

                Text("Duration: \(viewModel.durationText)")
                    .font(.headline)

                Text("Distance: \(viewModel.distanceText)")
                    .font(.headline)

                Text("Steps: \(viewModel.stepsText)")
                    .font(.headline)

                Text("Current Pace: \(viewModel.paceText)")
                    .font(.headline)

                Text("Last Location: \(viewModel.locationText)")
                    .font(.headline)

                Button("Stop Recording") {
                    viewModel.stopRecording()
                }
                    .buttonStyle(.borderedProminent)
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct RunRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RunRecordingView()
    }
}
