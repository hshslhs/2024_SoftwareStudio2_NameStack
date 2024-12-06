//
//  CategoryTag.swift
//  NameStack_tabbar
//
//  Created by 김세연 on 11/12/24.
//

import SwiftUI
import SwiftData

struct CategoryTag: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path: NavigationPath
    @Binding var isTabBarVisible: Bool
    @Binding var selectedTab: Int
    
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \NameTag.name, order: .forward) private var tags: [NameTag]

    @State private var selectedTagIndex: UUID? = nil
    @State private var showEditName = false
    @State private var editedName: String = ""
    @State private var editingIndex: UUID? = nil

    let paletteColors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple, .brown, .gray]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            
            Button(action: {
                withAnimation {
                isTabBarVisible=false
                isSidebarVisible.toggle()
                }
            }) {
                Image("sidebar")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 30, height: 30)
            .position(x: 50, y: 20);
            
            Text("NameStack")
                .font(Font.custom("Jura", size: 30).weight(.bold))
                .foregroundColor(.white)
                .frame(width: 175, height: 35)
                .position(x: UIScreen.main.bounds.width / 2, y: 20);
            
            Button(action: {
                path = NavigationPath()
                selectedTab = 0
                isTabBarVisible=true
            }) {
                Image("Home")
                    .padding(
                        EdgeInsets(top: 7.50, leading: 3.75, bottom: 7.50, trailing: 3.75)
                    )
            }
            .frame(width: 30, height: 30)
            .position(x: UIScreen.main.bounds.width-50, y: 20);
            
            Button(action: addNewTag) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
            }
            .frame(width: 30, height: 30)
            .position(x: UIScreen.main.bounds.width-50, y: 80);
            VStack {
                        
                // Tag List
                List {
                    ForEach(tags) { tag in
                        VStack(spacing: 10) {
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        selectedTagIndex = (selectedTagIndex == tag.id) ? nil : tag.id
                                        editingIndex = nil
                                        showEditName = false
                                    }

                                }) {
                                    Circle()
                                        .fill(paletteColors[tag.colorIndex])
                                        .frame(width: 30, height: 30)
                                } .buttonStyle(PlainButtonStyle())
                                .contentShape(Circle())

                                Text(tag.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 10)

                                Spacer()

                                Button(action: {
                                    editingIndex = tag.id
                                    editedName = tag.name
                                    showEditName = true
                                    selectedTagIndex = nil
                                }) {
                                    Image("edit")
                                        .foregroundColor(.white)
                                        .frame(width: 25, height: 25)
                                }                                .buttonStyle(PlainButtonStyle()).contentShape(Rectangle())
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(paletteColors[tag.colorIndex].opacity(0.2))
                            ).frame(width:350, height:50)

                            
                            
                            //팔레트
                            if selectedTagIndex == tag.id {
                                HStack(spacing: 10) {
                                    ForEach(paletteColors, id: \.self) { color in
                                        Circle()
                                            .fill(color)
                                            .frame(width: 30, height: 30)
                                            .onTapGesture {
                                                if let index = tags.firstIndex(where: { $0.id == tag.id }) {
                                                    tags[index].colorIndex = colorToIndex(color: color)
                                                }
                                                withAnimation {
                                                    selectedTagIndex = nil
                                                }
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .listRowBackground(Color.black)
                    }
                    .onDelete(perform: deleteTag)//스와이프해서 삭제
                }
                .scrollContentBackground(.hidden)
            }
            .padding(.top,100)
        }
        .navigationBarBackButtonHidden(true)
        
        .alert("Edit Tag Name", isPresented: $showEditName) {
            TextField("Tag Name", text: $editedName)
            Button("Save", action: saveEditedName)
            Button("Cancel", role: .cancel) { showEditName = false }
        }
    }
    
    private func colorToIndex(color: Color) -> Int {
        switch color{
        case .red:
            return 0
        case .orange:
            return 1
        case .yellow:
            return 2
        case .green:
            return 3
        case .blue:
            return 4
        case .indigo:
            return 5
        case .purple:
            return 6
        case .brown:
            return 7
        default:
            return 8
        }
    }

    private func addNewTag() {
        modelContext.insert(NameTag(name: "New Tag", color: 8))
    }

    private func deleteTag(at offsets: IndexSet) {
        modelContext.delete(tags[offsets.first!])
    }

    private func saveEditedName() {
        if let id = editingIndex, let index = tags.firstIndex(where: { $0.id == id }) {
            tags[index].name = editedName
        }
        showEditName = false
    }
}

struct Tag: Identifiable {
    let id = UUID()
    var name: String
    var color: Color
}

#Preview {
    ContentView()
}

