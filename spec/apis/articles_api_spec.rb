require 'rspec_helper'
RSpec.describe ArticlesApi do
  let(:articles) { create_list(:article, 10) }
  describe 'GET /articles' do
    before do
      articles
    end

    it 'should response articles' do
      pending
    end
    it 'should response 200' do
      pending
    end
  end
end
