require 'rails_helper'

RSpec.describe 'ArticlesController', type: :request do
  context 'index' do
    it 'should return status ok' do
      # request
      get articles_index_path

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
          title: 'Tenha sucesso profissional',
          body: 'Faça Análise de Sistemas na Guairacá'
        }
      )

      # request
      get articles_index_path

      # what expect
      expect(response).to have_http_status(:success)
      expect(response.body).to include article.title
      expect(response.body).to include article.body
      expect(response.body).to include other_article.title
      expect(response.body).to include other_article.body
    end
  end
end
