# FunRun

A simple iOS app for recording runs. Tap **Start Recording** and FunRun tracks your run in real time using the device's motion sensors and GPS.

> [!IMPORTANT]
> **FunRun must be run on a physical iPhone, not the iOS Simulator.**
> It relies on the pedometer (CoreMotion), which the Simulator doesn't have, so steps, distance and pace won't record there.

## Features

While recording, FunRun shows:

- **Duration**: elapsed time
- **Distance**: from the pedometer
- **Steps**: step count
- **Current pace**: in seconds per meter
- **Last location**: latest GPS coordinates, plus how many have been recorded

## Requirements

- **A physical iPhone** running iOS 26.1 or later (the Simulator is not supported)
- Xcode 26 or later
- An Apple ID signed in to Xcode, so you can sign the app and install it on your device

## Getting Started

1. Clone the repo:
   ```sh
   git clone git@github.com:milliesavalia/FunRun.git
   ```
2. Open `FunRun.xcodeproj` in Xcode.
3. Connect your iPhone, choose it as the run destination (not a Simulator), and press **Run** (⌘R).
4. Grant Motion & Fitness and Location access when prompted.

## Project Structure

| Path | Description |
| --- | --- |
| `FunRun/RunRecorder/` | `RunRecorder` collects data from `CMPedometer` (CoreMotion) and `CLLocationManager` (CoreLocation) and builds a `RunSummary` |
| `FunRun/Run/` | The recording screen: a SwiftUI `RunRecordingView` and its view model, hosted in UIKit by `RunRecordingVC` |
| `FunRunTests/` | Unit tests |
| `FunRunUITests/` | UI tests |
