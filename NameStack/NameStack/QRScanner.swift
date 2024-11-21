//
//  QRScanner.swift
//  NameStack_tabbar
//
//  Created by 이현서 on 11/5/24.
//

import SwiftUI
import UIKit

struct QRScanner: View {
    @Binding var isSidebarVisible: Bool
    @Binding var path:NavigationPath
    @Binding var isTabBarVisible: Bool

    
    var body: some View {

        ZStack {
                    Color.black
                        .ignoresSafeArea()
                    
            Text("QRScanner").foregroundStyle(.white)
                }

    }
}
