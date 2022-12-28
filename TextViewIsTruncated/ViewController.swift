//
//  ViewController.swift
//  TextViewIsTruncated
//
//  Created by Salman Biljeek on 12/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    let textView1: UITextView = {
        let textView = UITextView()
        textView.text = "Truncated"
        textView.font = .boldSystemFont(ofSize: 22)
        textView.textColor = .white
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textView
    }()
    let textView2: UITextView = {
        let textView = UITextView()
        textView.text = "Truncated"
        textView.font = .boldSystemFont(ofSize: 22)
        textView.textColor = .white
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return textView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.textColor = .systemPink
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.textColor = .systemPink
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        
        let stack1 = UIStackView(arrangedSubviews: [
            textView1,
            label1
        ])
        stack1.axis = .horizontal
        stack1.spacing = 3
        stack1.alignment = .center
        
        let stack2 = UIStackView(arrangedSubviews: [
            textView2,
            label2
        ])
        stack2.axis = .horizontal
        stack2.spacing = 3
        stack2.alignment = .center
        
        let mainStack = UIStackView(arrangedSubviews: [
            stack1,
            stack2
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 3
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainStack)
        mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 115).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -115).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let isText1Truncated = textView1.isTextTruncated
        let isText2Truncated = textView2.isTextTruncated
        
        label1.text = String(isText1Truncated)
        label2.text = String(isText2Truncated)
    }
}

extension UITextView {
    var isTextTruncated: Bool {
        var isTruncating = false
        
        // The `truncatedGlyphRange(...) method will tell us if text has been truncated
        // based on the line break mode of the text container
        layoutManager.enumerateLineFragments(forGlyphRange: NSRange(location: 0, length: Int.max)) { _, _, _, glyphRange, stop in
            let truncatedRange = self.layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: glyphRange.lowerBound)
            if truncatedRange.location != NSNotFound {
                isTruncating = true
                stop.pointee = true
            }
        }
        
        // It's possible that the text is truncated not because of the line break mode,
        // but because the text is outside the drawable bounds
        if isTruncating == false {
            let glyphRange = layoutManager.glyphRange(for: textContainer)
            let characterRange = layoutManager.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            
            let totalTextCount = text.utf16.count
            isTruncating = characterRange.upperBound < totalTextCount
        }
        
        return isTruncating
    }
}
