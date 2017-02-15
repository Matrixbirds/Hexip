module Articles
  def index
    @articles = Article.page(params[:page]).per(params[:per])
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

end
