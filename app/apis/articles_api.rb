class ArticlesApi

  def self.instance
    @instance ||= new
  end

  def index(_ctx, params=_ctx.req.params)
    articles = Article.page(params&.dig("page")).per(params&.dig("per"))
    json = { articles: articles }.to_json
    [200, {'Content-Type'=> 'application/json', 'Content-Length'=> "#{json.size}"}, [json]]
  end

  def show(_ctx, params=_ctx.req.params)
    article = Article.find(params&.dig("id"))
    json = { article: article }.to_json
    [200, {'Content-Type'=> 'application/json', 'Content-Length'=> "#{json.size}"}, [json]]
  end

  def create
  end

  def update
  end

  def destroy
  end

end
