import SwiftUI

struct EditListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var editedList: ListModel
    @State private var newItemTitle = ""
    let onUpdate: (ListModel) -> Void

    init(list: ListModel, onUpdate: @escaping (ListModel) -> Void) {
        _editedList = State(initialValue: list)
        self.onUpdate = onUpdate
    }

    var body: some View {
        NavigationView {
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
                            Text(item.title)
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
    }
}
