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
    @Binding var path: NavigationPath

    var dataToScanFor: Set<DataScannerViewController.RecognizedDataType>
    
    func parseQrText(){
        //텍스트 파싱하기
        let lines = scannedText.split(separator: "\n", maxSplits: 7)
        var result : [String] = []
        if(lines.count != 7){
            return
        }
        for line in lines {
            // 각 줄에서 ': '로 구분하여 키와 값을 나눔
            let parts = line.split(separator: ":", maxSplits: 1)
            if parts.count == 2 {
                //let key = parts[0].trimmingCharacters(in: .whitespaces)
                let value = parts[1].trimmingCharacters(in: .whitespaces)
                result.append(value)
            }
            else{
                let value = ""
                result.append(value)
            }
        }
        let scannedCard = Card(name: result[0],phoneNumber: result[2],mail: result[3],organization: result[1],school: result[4],URL: result[5],memo: result[6])
        withAnimation{ path.append(MainDestination.editScanned(scannedCard))}
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
            parent.parseQrText()
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
