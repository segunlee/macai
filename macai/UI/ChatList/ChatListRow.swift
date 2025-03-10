//
//  ChatListRow.swift
//  macai
//
//  Created by Renat on 17.11.2024.
//

import SwiftUI

struct ChatListRow: View, Equatable {
    static func == (lhs: ChatListRow, rhs: ChatListRow) -> Bool {
        lhs.chat?.id == rhs.chat?.id &&
        lhs.chat?.updatedDate == rhs.chat?.updatedDate &&
        lhs.chat?.name == rhs.chat?.name &&
        lhs.chat?.lastMessage?.body == rhs.chat?.lastMessage?.body &&
        lhs.searchText == rhs.searchText &&
        (lhs.selectedChat?.id == rhs.selectedChat?.id)
    }
    let chat: ChatEntity?
    let chatID: UUID  // Store the ID separately
    @Binding var selectedChat: ChatEntity?
    let viewContext: NSManagedObjectContext
    var searchText: String = ""
    @StateObject private var chatViewModel: ChatViewModel

    init(
        chat: ChatEntity?,
        selectedChat: Binding<ChatEntity?>,
        viewContext: NSManagedObjectContext,
        searchText: String = ""
    ) {
        self.chat = chat
        self.chatID = chat?.id ?? UUID()
        self._selectedChat = selectedChat
        self.viewContext = viewContext
        self.searchText = searchText
        self._chatViewModel = StateObject(wrappedValue: ChatViewModel(chat: chat!, viewContext: viewContext))
    }

    var isActive: Binding<Bool> {
        Binding<Bool>(
            get: {
                selectedChat?.id == chatID
            },
            set: { newValue in
                if newValue {
                    selectedChat = chat
                }
                else {
                    selectedChat = nil
                }
            }
        )
    }

    var body: some View {
        MessageCell(
            chat: chat!,
            timestamp: chat?.lastMessage?.timestamp ?? Date(),
            message: chat?.lastMessage?.body ?? "",
            isActive: isActive,
            viewContext: viewContext,
            searchText: searchText
        )
        .contextMenu {
            Button(action: { renameChat(chat!) }) {
                Label("Rename", systemImage: "pencil")
            }
            if chat!.apiService?.generateChatNames ?? false {
                Button(action: {
                    chatViewModel.regenerateChatName()
                }) {
                    Label("Regenerate Name", systemImage: "arrow.clockwise")
                }
            }
            Button(action: { clearChat(chat!) }) {
                Label("Clear Chat", systemImage: "eraser")
            }
            Divider()
            Button(action: { deleteChat(chat!) }) {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    func deleteChat(_ chat: ChatEntity) {
        let alert = NSAlert()
        alert.messageText = String(format: String(localized: "Delete chat %@"), chat.name)
        alert.informativeText = String(localized: "Are you sure you want to delete this chat?")
        alert.addButton(withTitle: String(localized: "Delete"))
        alert.addButton(withTitle: String(localized: "Cancel"))
        alert.alertStyle = .warning
        alert.beginSheetModal(for: NSApp.keyWindow!) { response in
            if response == .alertFirstButtonReturn {
                // Clear selectedChat to prevent accessing deleted item
                if selectedChat?.id == chat.id {
                    selectedChat = nil
                }
                viewContext.delete(chat)
                DispatchQueue.main.async {
                    do {
                        try viewContext.save()
                    }
                    catch {
                        print("Error deleting chat: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    func renameChat(_ chat: ChatEntity) {
        let alert = NSAlert()
        alert.messageText = String(localized: "Rename chat")
        alert.informativeText = String(localized: "Enter new name for this chat")
        alert.addButton(withTitle: String(localized: "Rename"))
        alert.addButton(withTitle: String(localized: "Cancel"))
        alert.alertStyle = .informational
        let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        textField.stringValue = chat.name
        alert.accessoryView = textField
        alert.beginSheetModal(for: NSApp.keyWindow!) { response in
            if response == .alertFirstButtonReturn {
                chat.name = textField.stringValue
                do {
                    try viewContext.save()
                }

                catch {
                    print("Error renaming chat: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func clearChat(_ chat: ChatEntity) {
        let alert = NSAlert()
        alert.messageText = String(format: String(localized: "Clear chat %@?"), chat.name)
        alert.informativeText = String(localized: "Are you sure you want to delete all messages from this chat? Chat parameters will not be deleted. This action cannot be undone.")
        alert.addButton(withTitle: String(localized: "Clear"))
        alert.addButton(withTitle: String(localized: "Cancel"))
        alert.alertStyle = .warning
        alert.beginSheetModal(for: NSApp.keyWindow!) { response in
            if response == .alertFirstButtonReturn {
                chat.clearMessages()
                do {
                    try viewContext.save()
                } catch {
                    print("Error clearing chat: \(error.localizedDescription)")
                }
            }
        }
    }
}
