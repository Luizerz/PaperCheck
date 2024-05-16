//
//  NoticeEntity.swift
//  PaperCheck
//
//  Created by Luiz Sena on 14/05/24.
//

import Foundation

struct NoticeEntity {
    let status: String
    let totalResults: Int
    let articles: [ArticleEntity]

    init(notice: Notice) {
        self.status = notice.status
        self.totalResults = notice.totalResults
        self.articles = notice.articles.map {
            return ArticleEntity(
                source: .init(id: $0.source.id ?? "ID Inválido", name: $0.source.name),
                author: $0.author ?? "Desconhecido",
                title: $0.title,
                description: $0.description ?? "Não há descrição",
                url: $0.url,
                urlToImage: $0.urlToImage ?? "Url inválida",
                publishedAt: $0.publishedAt,
                content: $0.content ?? "Sem conteúdo"
            )
        }
    }
}

struct ArticleEntity: Codable {
    let source: SourceEntity
    let author: String
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String?
}

struct SourceEntity: Codable {
    let id: String
    let name: String
}
