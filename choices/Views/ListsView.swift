import SwiftUI

struct ListsView: View {
    @StateObject private var viewModel = ListsViewModel()
    @State private var showingCreateSheet = false
    @State private var listToEdit: ListModel?

    var body: some View {
        NavigationView {
            SwiftUI.List {
                ForEach(viewModel.lists) { list in
                    ListRow(list: list) {
                        listToEdit = list
                    }
                }
                .onDelete(perform: viewModel.deleteList)
            }
            .navigationTitle("我的清单")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingCreateSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingCreateSheet) {
                // TODO:
            }
            .sheet(item: $listToEdit) { list in
                EditListView(list: list) { updatedList in
                    viewModel.updateList(updatedList)
                }
            }
        }
    }
}

// 列表行组件
struct ListRow: View {
    let list: ListModel
    let onEdit: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(list.name)
                    .font(.headline)
                Text("项目数: \(list.items.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: onEdit) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 8)
    }
}