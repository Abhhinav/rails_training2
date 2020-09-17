class Post < ApplicationRecord
    belongs_to :category
    belongs_to :user
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_many :comments
    has_rich_text :body
    #default_scope
    default_scope {order :created_at}
    scope :published, -> {where(published: true)}
    scope :notpublished, -> {where.not(published: true)}
    #overriding the default
    scope :order_by_latest, ->{reorder(created_at: :desc)}

    attr_accessor :all_tags
    
    after_save :assign_tags

  def assign_tags 
    if @all_tags.blank?
      return
    end
    # tag_names: => tag1, tag2, tag3
    # NOTE: DO NOTE USE all_tags below as it will call getter
    #       USE @all_tags
    self.tags = @all_tags.split(",").map do |tag_name|
       unless tag_name.blank?
          Tag.where(name: tag_name.strip).first_or_create!
       end
    end
  end

  def all_tags 
    tags.map(&:name).join(", ")
  end
end
