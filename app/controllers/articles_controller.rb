class ArticlesController < ApplicationController
    #ordering of these before actions matter.
    before_action :find_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.paginate(page: params[:page], per_page: 5)
    end

    def show
        # byebug
        #@makes it an instance variable which is available to the rest of the application, otherwise it would just be available in the method.
    end

    def new
        @article = Article.new #gens an empty article when first load the page
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was created successfully" #notice and alert are the common keys used
            redirect_to @article #extracts the id from the @article object 
        else 
            flash[:alert] = "Article was not created"
            render 'new'
        end
    end

    def edit
        
    end

    def update
       if @article.update(article_params)
            flash[:notice] = "Article was updated"
            redirect_to @article
       else
            flash[:notice] = "Article was not updated"
            render 'edit'
       end

    end

    def destroy
       if @article.destroy
            flash[:notice] =  "Article Deleted"
            redirect_to articles_path
       else
            flash[:alert] = "Article Failed to Delete"
            render @article
       end
    end

  


    private
    def article_params
        params.require(:article).permit(:title, :description)
    end

    def find_article
        @article = Article.find(params[:id])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You can only edit or delete your own article"
            redirect_to @article
        end
    end
end
