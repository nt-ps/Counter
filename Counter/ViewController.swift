//
//  ViewController.swift
//  Counter
//
//  Created by Антон on 08.01.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var incrementButton: UIButton!
    
    @IBOutlet private weak var decrementButton: UIButton!
    
    @IBOutlet private weak var resetButton: UIButton!
    
    @IBOutlet private weak var historyTextView: UITextView!
    
    private var counterValue: UInt = 0
    
    private var history: String = ""
    
    private let dateFormatter: DateFormatter = DateFormatter()
    
    private var date: String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    private var counterText: String { "Значение счетчика: \(counterValue)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTextView.layer.cornerRadius = 10.0;
        historyTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        counterValue = UserDefaults.standard.object(forKey: "lastCounterValue") as? UInt ?? 0
        history = UserDefaults.standard.string(forKey: "history") ?? ""
        
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        addToHistory(event: "счетчик открыт")
        updateText()
    }
    
    private func updateText() {
        counterLabel.text = counterText
        historyTextView.text = history
        
        UserDefaults.standard.set(counterValue, forKey: "lastCounterValue")
        UserDefaults.standard.set(history, forKey: "history")
    }
    
    private func addToHistory(event: String) {
        history = "\(date) - \(event)\n\(history)"
    }
    
    @IBAction private func incrementButtonDidTap(_ sender: Any) {
        counterValue += 1
        addToHistory(event: "значение изменено на +1")
        updateText()
    }
    
    @IBAction private func decrementButtonDidTap(_ sender: Any) {
        if counterValue > 0 {
            counterValue -= 1
            addToHistory(event: "значение изменено на -1")
        } else {
            addToHistory(event: "попытка уменьшить значение счётчика ниже 0")
        }
        updateText()
    }
    
    @IBAction private func resetButtonDidTap(_ sender: Any) {
        counterValue = 0
        addToHistory(event: "значение сброшено")
        updateText()
    }
}

