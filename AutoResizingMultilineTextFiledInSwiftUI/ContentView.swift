//
//  ContentView.swift
//  AutoResizingMultilineTextFiledInSwiftUI
//
//  Created by Ramill Ibragimov on 25.12.2019.
//  Copyright © 2019 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var obj: observed
    
    var body: some View {
        VStack {
            MultiTextField()
                .frame(height: self.obj.size < 150 ? self.obj.size : 150)
                .padding(10)
                .background(Color.yellow)
                .cornerRadius(10)
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MultiTextField: UIViewRepresentable {
    
    func makeCoordinator() -> MultiTextField.Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
 
    @EnvironmentObject var obj: observed
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.text = "Type Something"
        view.textColor = UIColor.black.withAlphaComponent(0.35)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        
        self.obj.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultiTextField
        init(parent1: MultiTextField) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.obj.size = textView.contentSize.height
        }
    }
}

class observed: ObservableObject {
    
    @Published var size: CGFloat = 0
}

