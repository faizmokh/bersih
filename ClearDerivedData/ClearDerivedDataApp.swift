import SwiftUI

@main
struct ClearDerivedDataApp: App {
    var body: some Scene {
        MenuBarExtra {
            Button {
                deleteDerivedData()
            } label: {
                Text("Clear Derived Data")
            }
            .keyboardShortcut("1")
            Button {
                openDerivedDataFolder()
            } label: {
                Text("Open Derived Data Folder")
            }
            .keyboardShortcut("2")
            Divider()
            Button("About") {
                showAboutPanel()
            }
            Button("Quit") {
                NSApplication.shared.terminate(self)
            }
            .keyboardShortcut("q")
        } label: {
            Image(systemName: "app.fill")
                .imageScale(.large)
                .foregroundColor(.accentColor)
        }

    }
    
    private func deleteDerivedData() {
        let fileManager = FileManager.default
        let homeDirectory = NSHomeDirectory()
        
        let derivedDataURL = URL(fileURLWithPath: homeDirectory)
            .appendingPathComponent("Library/Developer/Xcode/DerivedData")
        do {
            let derivedDataContents = try fileManager.contentsOfDirectory(
                at: derivedDataURL,
                includingPropertiesForKeys: nil
            )
            for file in derivedDataContents {
                try fileManager.removeItem(at: file)
            }
            print("Derived data cleared!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func openDerivedDataFolder() {
        let homeDirectory = NSHomeDirectory()
        let derivedDataPath = URL(fileURLWithPath: homeDirectory)
            .appendingPathComponent("Library/Developer/Xcode/DerivedData")
        
        NSWorkspace.shared.open(derivedDataPath)
    }
    
    private func showAboutPanel() {
        NSApplication.shared.orderFrontStandardAboutPanel(options: [
            NSApplication.AboutPanelOptionKey.applicationName: Bundle.main.displayName,
            NSApplication.AboutPanelOptionKey.version: "1.0.0",
            NSApplication.AboutPanelOptionKey.credits: NSAttributedString(
                string: "A simple menu bar app to quickly clear Xcode's Derived Data folder."
            ),
            NSApplication.AboutPanelOptionKey(
                rawValue: "Copyright"
            ): "© 2023 FAIZ MOKHTAR"
        ])
    }
}

extension Bundle {
    var displayName: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as! String
    }
}
