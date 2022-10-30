//
//  NewsTabView.swift
//  The News Portal
//
//  Created by Safal Neupane on 26/10/2022.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsVM.selectedCategory, loadTask )
                .navigationTitle(articleNewsVM.selectedCategory.text)
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsVM.phase {
        case.empty: ProgressView()
        case .success(let articles) where articles.isEmpty: EmptyPlaceholderView(text: "No Articles", image: nil)
        case .failure(let error): EmptyPlaceholderView(text: error.localizedDescription, image: nil)
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsVM.phase {
            return articles
        } else {
             return []
        }
    }
    
    private func loadTask() async {
            await articleNewsVM.loadArticles()
    }
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsVM.selectedCategory) {
                ForEach(Category.allCases) {
                    Text($0.text)
                }
            }
        } label: {
            Image(systemName: "fiberchannel")
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
    }
}
