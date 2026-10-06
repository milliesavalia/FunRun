# FunRun

A simple iOS app for recording runs. Tap **Start Recording** and FunRun tracks your run in real time using the device's motion sensors and GPS.

## Features

While recording, FunRun shows:

- **Duration**: elapsed time
- **Distance**: from the pedometer
- **Steps**: step count
- **Current pace**: in seconds per meter
- **Last location**: latest GPS coordinates, plus how many have been recorded

## Requirements

- Xcode 26 or later
- iOS 26.1 or later
- A physical iPhone is recommended, because the Simulator doesn't provide pedometer data

## Getting Started

1. Clone the repo:
   ```sh
   git clone git@github.com:milliesavalia/FunRun.git
   ```
2. Open `FunRun.xcodeproj` in Xcode.
3. Select your device and press **Run** (⌘R).
4. Grant Motion & Fitness and Location access when prompted.

## Project Structure

| Path | Description |
| --- | --- |
| `FunRun/RunRecorder/` | `RunRecorder` collects data from `CMPedometer` (CoreMotion) and `CLLocationManager` (CoreLocation) and builds a `RunSummary` |
| `FunRun/Run/` | The recording screen: a SwiftUI `RunRecordingView` and its view model, hosted in UIKit by `RunRecordingVC` |
| `FunRunTests/` | Unit tests |
| `FunRunUITests/` | UI tests |
