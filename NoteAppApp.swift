//
//  NoteAppApp.swift
//  NoteApp
//
//  Created by 高橋蓮 on 2022/03/14.
//

import SwiftUI

@main
struct NoteAppApp: App {
    @StateObject private var note = Notes()
    var body: some Scene {
        WindowGroup {
            MainView(note: note)
        }
    }
}
