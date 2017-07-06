class Article < ActiveRecord::Base
    belongs_to :user
    has_many :article_categories
    has_many :categories, through: :article_categories
    validates :title, presence: true, length: {minimum: 3, maximum: 55}
    validates :description, presence: true
    
    def self.search(params)
        articles = all
        articles = where("title like ? or description like?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search]
        articles
    end
    
end