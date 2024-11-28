class ArticlesController < ApplicationController
  before_action :check_admin, only: [:new, :create]

    def index
      @articles = Article.page(params[:page]).per(6)
    end
  
    def show
      @article = Article.find_by!(slug: params[:id]) || Article.find(params[:id]) # Recherche par slug mais si aucun slug match, il cherche par id.
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to article_path(@article), notice: "Produit créé avec succès !"
      else
        render :new, alert: "Une erreur s'est produite."
      end
    end

    private 

    def article_params
      params.require(:article).permit(:name, :description, :price)
    end

    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à effectuer cette action."
      end
    end

end
  