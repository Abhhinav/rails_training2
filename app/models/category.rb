class Category < ApplicationRecord
    validates :name, presence: true
    has_many :posts, dependent: :destroy
    before_save :create_slug

    def create_slug 
      # self => point the instance of category
      self.slug = self.name.downcase.tr(" ", "-")    # Web Development => web-development
    end
end
