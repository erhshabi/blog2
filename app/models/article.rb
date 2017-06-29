class Article < ActiveRecord::Base
    belongs_to :user
    validates :title, presence: true, length: {minimum: 3, maximum: 55}
    validates :description, presence: true
end