class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit,:update,:destroy]
    before_action :require_user, only: [:new, :edit, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.order("updated_at DESC").search(params).paginate(page: params[:page], per_page: 5)
    end
    def new
        @article = Article.new
    end
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Пост успешно создан!"
          redirect_to articles_path  
        else
            render "new"
        end
    end
    
    def show
    end
    def edit
    end
    def update
        if @article.update(article_params)
            flash[:notice] = "Пост обнoвлен!"
            redirect_to article_path(@article)
        else
            render "edit"
        end
    end
    def destroy
        @article.destroy
        flash[:notice] = "Пост успешно удален!"
        redirect_to articles_path
    end
    private
    def article_params
        params.require(:article).permit(:title, :description, category_ids: [])
    end
    def set_article
        @article = Article.find(params[:id])
    end
    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:danger] = "this is not ur article mazafaka"
            redirect_to articles_path
        end
    end
end