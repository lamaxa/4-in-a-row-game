//
//  ViewController.swift
//  ConnectFourTutorial
//
//  Created by Lama Alqahtani  on 15/12/2025.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var turnImage: UIImageView!
    
    var redScore = 0
    var yellowScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        resetBoard()
        setCellWidthHeight()
    }

    // MARK: - Cell Size
    func setCellWidthHeight() {
        let width = collectionView.frame.size.width / 9
        let height = collectionView.frame.size.height / 6

        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    // MARK: - CollectionView DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }

    func collectionView(_ cv: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {

        let cell = cv.dequeueReusableCell(
            withReuseIdentifier: "idCell",
            for: indexPath
        ) as! BoardCell

        let boardItem = getBoardItem(indexPath)
        cell.image.tintColor = boardItem.tileColor()

        return cell
    }

    // MARK: - CollectionView Delegate
    func collectionView(_ cv: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        let column = indexPath.item

        if var boardItem = getLowestEmptyBoardItem(column) {

            if let cell = collectionView.cellForItem(
                at: boardItem.indexPath
            ) as? BoardCell {

                cell.image.tintColor = currentTurnColor()
                boardItem.tile = currentTurnTile()
                updateBoardWithBoardItem(boardItem)
            }

            if horizontalVictory() ||
               verticalVictory() ||
               diagonalVictory() {

                if currentTurn == .Yellow {
                    yellowScore += 1
                } else {
                    redScore += 1
                }

                resultAlert(title: "Victory")
                return
            }

            if boardIsFull() {
                resultAlert(title: "Draw")
                return
            }

            toggleTurn(turnImage)
        }
    }

    // MARK: - Board Logic
    func boardIsFull() -> Bool {
        for row in board {
            for column in row {
                if column.emptyTile() {
                    return false
                }
            }
        }
        return true
    }

    // MARK: - Alerts
    func resultAlert(title: String) {

        let message = "Red: \(redScore)\nYellow: \(yellowScore)"

        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )

        ac.addAction(
            UIAlertAction(title: "Reset",
                          style: .default,
                          handler: { _ in
                resetBoard()
                self.resetCells()
            })
        )

        present(ac, animated: true)
    }

    // MARK: - Reset
    func resetCells() {
        for cell in collectionView.visibleCells {
            if let boardCell = cell as? BoardCell {
                boardCell.image.tintColor = UIColor.white
            }
        }
    }
}
