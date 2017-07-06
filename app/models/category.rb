class Category < ActiveRecord::Base
    has_many :article_categories
    has_many :articles, through: :article_categories
    validates :name, presence: true, length: {minimum: 2, maximum: 13}, uniqueness: {case_sensitive: true}
end