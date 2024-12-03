//
//  DataScannerRepresentable.swift
//  NameStack_tabbar
//
//  Created by 이현서 on 11/19/24.
//


//
//  ARCameraCell.swift
//  TeslaModelAppQuiz1
//
//  Created by 이주헌 on 11/6/24.
//

import SwiftUI
import VisionKit

struct DataScannerRepresentable: UIViewControllerRepresentable {
    @Binding var shouldStartScanning: Bool
    @Binding var scannedText: String

    var dataToScanFor: Set<DataScannerViewController.RecognizedDataType>
    
    func parseQrText()-> Card{
        let scannedCard = Card(name: "",phoneNumber: "",mail: "",organization: "",school: "",URL: "",memo: "")
        return scannedCard;
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
       var parent: DataScannerRepresentable
       
       init(_ parent: DataScannerRepresentable) {
           self.parent = parent
       }
               
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {

            switch item {
            case .text(let text):
                parent.scannedText = text.transcript
                print("unexpected item")
            case .barcode(let barcode):
                parent.scannedText = barcode.payloadStringValue ?? "Unable to decode the scanned code"
            default:
                print("unexpected item")
            }
        }
    }
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let dataScannerVC = DataScannerViewController(
            recognizedDataTypes: dataToScanFor,
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isPinchToZoomEnabled: true,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        
        dataScannerVC.delegate = context.coordinator
       
       return dataScannerVC
    }

    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
       if shouldStartScanning {
           try? uiViewController.startScanning()
       } else {
           uiViewController.stopScanning()
       }
    }

    func makeCoordinator() -> Coordinator {
       Coordinator(self)
    }
}
