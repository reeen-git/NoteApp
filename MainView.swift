//
//  ContentView.swift
//  NoteApp
//
//  Created by 高橋蓮 on 2022/03/14.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var note: Notes
    @State var searchString: String = ""
    @State var newFolderName: String = ""
    @State var showingPopover = false
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    TextField("Search", text: $searchString)
                    Section(header:
                                Text("On my iphone")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.black)) {
                        if note.folders.count > 0 {
                            FolderCell(name: "All on my Iphone")
                        }
                        ForEach (note.folders) { folder in
                            FolderCell(name: folder.name)
                        }
                    }
                                .textCase(nil)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Folders")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            print("edit")
                        }
                    }
                    ToolbarItemGroup(placement: .bottomBar) {
                        Image(systemName: "folder.badge.plus")
                            .onTapGesture {
                                showingPopover.toggle()
                            }
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            if showingPopover {
                CreateNewFolder($showingPopover, with: note)
            }
        }
    }
}


struct FolderCell: View {
    var name: String
    var body: some View {
        HStack {
            Image(systemName: "folder")
            Text(name)
        }
    }
}

struct CreateNewFolder: View {
    @State var newFolderName = ""
    @ObservedObject var note: Notes
    @Binding var showingPopover: Bool
    init(_ showingPopover: Binding<Bool>, with notes: Notes) {
        self._showingPopover = showingPopover
        self.note = notes
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(Color(.systemGray4))
                    .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.40, alignment: .center)
                VStack {
                    Text("NewFolder")
                    Text("Enter a name for this folder.")
                    TextField("Name", text: $newFolderName)
                        .frame(width: 200, height: 30)
                        .background(.white)
                        .padding()
                        .cornerRadius(7)
                    Spacer()
                    Color.gray.frame(width: 200, height: CGFloat(1))
                    HStack {
                        Button(action: {print("cancel")}) {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                        }
                        Button(action: {
                            note.folders.append(Folder(name: newFolderName))
                            showingPopover.toggle()
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .frame(width: geo.size.width * 0.70, height: geo.size.width * 0.35)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let testNotes = Notes()
        testNotes.folders = testFolders
        return MainView(note: testNotes)
    }
}
