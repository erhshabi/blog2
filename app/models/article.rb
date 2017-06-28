class Article < ActiveRecord::Base
    validates :title, presence: true, length: {minimum: 3, maximum: 55}
    validates :description, presence: true
end