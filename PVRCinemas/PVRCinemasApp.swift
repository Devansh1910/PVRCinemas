import SwiftUI

@main
struct PVRCinemasApp: App {
    init() {
        // Set the app to always use light mode
        UIView.appearance().overrideUserInterfaceStyle = .light
    }

    var body: some Scene {
        WindowGroup {
            OrderSnacksView()
        }
    }
}
