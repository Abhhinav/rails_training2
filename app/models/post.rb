class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_rich_text :body
    #default_scope
    default_scope {order :created_at}
    scope :published, -> {where(published: true)}
    scope :notpublished, -> {where.not(published: true)}
    #overriding the default
    scope :order_by_latest, ->{reorder(created_at: :desc)}
end
