import SwiftUI

struct EditListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ListsViewModel  // 改为 @StateObject
    @State private var editedList: ListModel
    @State private var newItemTitle = ""

    let onUpdate: (ListModel) -> Void
    
    init(list: ListModel, onUpdate: @escaping (ListModel) -> Void) {
        _editedList = State(initialValue: list)
        self.onUpdate = onUpdate
        _viewModel = StateObject(wrappedValue: ListsViewModel())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("清单信息")) {
                        TextField("清单名称", text: $editedList.name)
                    }
                    
                    Section(header: Text("添加新项目")) {
                        HStack {
                            TextField("项目名称", text: $newItemTitle)
                            Button("添加") {
                                if !newItemTitle.isEmpty {
                                    editedList.items.append(ListItem(title: newItemTitle))
                                    newItemTitle = ""
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("清单项目")) {
                        ForEach($editedList.items) { $item in
                            HStack {
                                Image(systemName: "line.3.horizontal")  // 添加这行显示拖动图标
                                    .foregroundColor(.gray)
                                // 使用 TextField 替换 Text，实现实时编辑
                                TextField("项目名称", text: $item.title)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Spacer()
                            }                    }
                        .onDelete { indexSet in
                            editedList.items.remove(atOffsets: indexSet)
                        }
                        .onMove { from, to in
                            editedList.items.move(fromOffsets: from, toOffset: to)
                        }
                    }
                }
                
                // 在这里添加按钮
                Button(action: {
                    viewModel.selectRandomItem(from: editedList)
                }) {
                    Text("替我选！")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
                .disabled(editedList.items.isEmpty)
                .padding()
            }
            .navigationTitle("编辑清单")
            .navigationBarItems(
                leading: Button("取消") { dismiss() },
                trailing: Button("保存") {
                    onUpdate(editedList)
                    dismiss()
                }
                    .disabled(editedList.name.isEmpty)
            )
        }
        .fullScreenCover(isPresented: $viewModel.showingRandomResult) {
            if let item = viewModel.selectedItem {
                RandomResultView(selectedItem: item)
            }
        }
    }
}
