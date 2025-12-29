//
//  Turn.swift
//  ConnectFourTutorial
//
//  Created by Lama Alqahtani  on 15/12/2025.
//

import Foundation
import UIKit

enum Turn {
    case Red
    case Yellow
}

// البداية: اللاعب الأصفر
var currentTurn = Turn.Yellow

// تبديل الدور + تغيير صورة الدور
func toggleTurn(_ turnImage: UIImageView) {
    if yellowTurn() {
        currentTurn = .Red
        turnImage.image = UIImage(named: "Red")
    } else {
        currentTurn = .Yellow
        turnImage.image = UIImage(named: "Yellow")
    }
}

// هل الدور الحالي Yellow؟
func yellowTurn() -> Bool {
    return currentTurn == Turn.Yellow
}

// هل الدور الحالي Red؟
func redTurn() -> Bool {
    return currentTurn == Turn.Red
}

// ترجع نوع القطعة الحالية
func currentTurnTile() -> Tile {
    return yellowTurn() ? Tile.Yellow : Tile.Red
}

// ترجع لون اللاعب الحالي
func currentTurnColor() -> UIColor {
    return yellowTurn() ? .systemYellow : .red
}

// رسالة الفوز
func currentTurnVictoryMessage() -> String {
    return yellowTurn() ? "Yellow Wins!" : "Red Wins!"
}
