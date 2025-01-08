//
//  ViewController.swift
//  Counter
//
//  Created by Антон on 08.01.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private var num: UInt = 0
    private var history: String = ""
    
    private let dateFormatter: DateFormatter = DateFormatter()
    private var date: String {
        let date = Date()
        return dateFormatter.string(from: date)
    }
    
    private var counterText: String {
        "Значение счетчика: \(num)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTextView.layer.cornerRadius = 10.0;
        historyTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        dateFormatter.dateFormat = "dd.MM.yy HH:mm:ss"
        addToHistory(event: "начало подсчета");
        updateText()
    }

    @IBAction func incrementButtonDidTap(_ sender: Any) {
        num += 1
        addToHistory(event: "значение изменено на +1");
        updateText()
    }
    
    @IBAction func decrementButtonDidTap(_ sender: Any) {
        if num > 0 {
            num -= 1
            addToHistory(event: "значение изменено на -1");
        } else {
            addToHistory(event: "попытка уменьшить значение счётчика ниже 0");
        }
        updateText()
    }
    
    @IBAction func resetButtonDidTap(_ sender: Any) {
        num = 0
        addToHistory(event: "значение сброшено")
        updateText()
    }
    
    private func updateText() {
        counterLabel.text = counterText
        historyTextView.text = history
    }
    
    private func addToHistory(event: String) {
        history = "\(date) - \(event)\n\(history)";
    }
}

