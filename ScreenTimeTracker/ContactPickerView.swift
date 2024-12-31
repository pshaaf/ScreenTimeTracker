//
//  ContactPickerView.swift
//  ScreenTimeTracker
//
//  Created by Paul Shaaf on 12/7/24.
//

import SwiftUI
import ContactsUI
import Contacts

struct ContactPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    var onSelectContact: (CNContact) -> Void
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        var parent: ContactPickerView
        
        init(_ parent: ContactPickerView) {
            self.parent = parent
        }
        
        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.isPresented = false
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.onSelectContact(contact)
            parent.isPresented = false
        }
    }
}
