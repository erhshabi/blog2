class CategoriesController < ApplicationController
    before_action :require_admin, except: [:show, :index]
    
    
    def index
        @categories = Category.all
    end
    
    def show
        @category = Category.find(params[:id])
        @category_articles = @category.articles
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 4)
    end
    
    def new
        @category = Category.new
    end
    
    def edit
        @categories = Category.find(params[:id])
    end
    
    def update
        @categories = Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Updated"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Категория была создана!"
          redirect_to categories_path
        else
            render "edit"
        end
    end
    
    def destroy
        @category.destroy
        flash[:success] = "Категория успешно удалена!"
        redirect_to categories_path
    end
    private
    
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_admin
        if !logged_in? || (logged_in? and !current_user.admin?)
            flash[:danger] = "Only admin user can perform this action"
            redirect_to categories_path
        end
    end
    
end