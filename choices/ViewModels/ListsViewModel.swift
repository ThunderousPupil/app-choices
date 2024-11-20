import Foundation
import SwiftUI
import Combine

class ListsViewModel: ObservableObject {
    @Published var lists: [ListModel] = []

    init() {
        // 添加一些测试数据
        lists = [
            ListModel(name: "购物清单", items: [
                ListItem(title: "买苹果"),
                ListItem(title: "买牛奶"),
                ListItem(title: "买面包")
            ]),
            ListModel(name: "待办事项", items: [
                ListItem(title: "写报告"),
                ListItem(title: "预约医生")
            ]),
            ListModel(name: "阅读列表", items: [
                ListItem(title: "Swift编程"),
                ListItem(title: "设计模式")
            ])
        ]
    }

    func addList(name: String) {
        let newList = ListModel(name: name)
        lists.append(newList)
    }
    
    func deleteList(at indexSet: IndexSet) {
        lists.remove(atOffsets: indexSet)
    }
    
    func updateList(_ list: ListModel) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists[index] = list
        }
    }
}
