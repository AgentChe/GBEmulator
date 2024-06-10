//
//  FilePicker.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 22.04.2024.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var gb: UTType { UTType(importedAs: GlobalDefinitions.ImportedTypesIds.gb )}
}

struct FilePickerUIRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIDocumentPickerViewController
    typealias PickedURLsCompletionHandler = (_ urls: [URL]) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    let types: [UTType]
    let allowMultiple: Bool
    let pickedCompletionHandler: PickedURLsCompletionHandler
    
    init(types: [UTType], allowMultiple: Bool, onPicked completionHandler: @escaping PickedURLsCompletionHandler) {
        self.types = types
        self.allowMultiple = allowMultiple
        self.pickedCompletionHandler = completionHandler
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: types, asCopy: true)
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = allowMultiple
        return picker
    }
    
    func updateUIViewController(_ controller: UIDocumentPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerUIRepresentable
        
        init(parent: FilePickerUIRepresentable) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            parent.pickedCompletionHandler(urls)
            parent.dismiss()
        }
    }
}
