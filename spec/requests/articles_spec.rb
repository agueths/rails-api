require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  context 'index' do
    it 'should return status ok' do
      # request
      get articles_path

      # what expect
      expect(response).to have_http_status(:success)
    end

    it 'should return all articles' do
      # articles
      article = Article.create(
        {
          title: 'Estudando Ruby',
          body: 'Faça meu workshop e aprenda a começar'
        }
      )
      other_article = Article.create(
        {
          title: 'TDD',
          body: 'Quando os testes vem antes'
        }
      )

      # request
      get articles_path

      # what expect
      expect(response).to have_http_status(:success)
      expect(response.body).to include article.title
      expect(response.body).to include article.body
      expect(response.body).to include other_article.title
      expect(response.body).to include other_article.body
    end
  end

  context 'show' do
    it 'should return an article' do
      article = Article.create(
        {
          title: 'Estudando Ruby',
          body: 'Faça meu workshop e aprenda a começar'
        }
      )

      get article_path(article)

      expect(response).to have_http_status(:success)
      expect(response.body).to include article.title
      expect(response.body).to include article.body
    end

    it 'should return not found if article does not exist' do
      get article_path(id: 999)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'create' do
    it 'should create a new article' do
      article = {
        article: {
          title: 'TDD',
          body: 'O melhor jeito de programar sem ter erros'
        }
      }

      post articles_path, params: article

      expect(response).to have_http_status(:success)
      expect(response.body).to include('TDD')
      expect(response.body).to include('O melhor jeito de programar sem ter erros')
      expect(Article.last.title).to eq('TDD')
    end

    it 'should create a new article with comment' do
      article = {
        article: {
          title: 'TDD',
          body: 'O melhor jeito de programar sem ter erros',
          comments_attributes: [
            {
              name: 'Alexandre',
              comment: 'É verdade'
            }
          ]
        }
      }

      post articles_path, params: article
      res = JSON.parse(response.body)

      expect(response).to have_http_status(:success)
      expect(response.body).to include('TDD')
      expect(response.body).to include('O melhor jeito de programar sem ter erros')
      expect(Comment.find_by(article_id: res['id'])).not_to be_nil
      expect(Article.last.title).to eq('TDD')
    end
  end
end
