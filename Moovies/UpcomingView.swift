//
//  UpcomingView.swift
//  Moovies
//
//  Created by NamaaIT Apple3 on 30/09/2026.
//

import SwiftUI

struct UpcomingView: View {
    var body: some View {
        VerticalListView(titles: Title.previewTitles)
    }
}

#Preview {
    UpcomingView()
}
