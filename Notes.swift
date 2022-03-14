//
//  Notes.swift
//  NoteApp
//
//  Created by 高橋蓮 on 2022/03/14.
//

import Foundation

class Notes: ObservableObject {
    @Published var folders = [Folder]()
}

struct Folder: Identifiable {
    var id = UUID()
    
    var name: String
}

var testFolders = [
Folder(name: "test1"),
Folder(name: "test2")
]
