class HomeController < ApplicationController
    def ok

        render plain: "OK"

    end
    def index 
        #views/controller/index.html.erb
        #render plain: "This is an index page!"
        @categories = Category.all.includes(:posts)
        @tags = Tag.all.includes(:posts)
        @posts = Post.includes(:tags).order_by_latest.published.page(params[:page]).per(5)
    end
    def tag_search
        if params.has_key? (:tag)
            result = Tag.where(name: params[:tag])
            @posts = result.blank? ? [] : result.first.posts
        end
        render "home/index"
    end
    def category_search_posts
        if params.has_key? (:category)
            result = Category.where(name: params[:category])
            @posts = result.blank? ? [] : result.first.posts
        end
        render "home/index"
    end
    def about

    end
    def read
        @post = Post.find(params[:id])
    end
    def contact

    end

end