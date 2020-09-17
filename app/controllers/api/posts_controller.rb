module Api
    class PostsController <  ActionController::API
      def index 
        @posts = Post.all 
        render json: @posts 
      end
  
      def show 
        @post = Post.find(params[:id])
        render json: @post 
      end
  
      def create 
  
        p "Creating a POST.."
        @post = Post.new(post_params)
        @post.user_id = params[:user_id]
  
        if @post.save 
          render json: @post 
        else 
          render json: {errors: @post.errors}, status: :unprocessable_entity
        end
      end
  
      def update  
        @post = Post.find(params[:id])
        if @post.user_id == current_user.id
          @post.update_attributes(post_params)
          render json: @post
        end
  
      end
  
      def destroy 
  
        puts "Post #{params[:id]} deleted by user #{params[:user_id]}..."
  
        @post = Post.find(params[:id])
        p @post
  
        p params[:user_id]  == @post.user_id
  
        # Get userid from token
        if @post.user_id == params[:user_id].to_i
          @post.destroy
          render json: {}
        else 
          render json: { errors: {post: ['not owned by user']}}, status: :forbidden
        end
      end
  
      private 
      def post_params
        params.require(:post)
              .permit(:user_id, :title, :body, :published, :category_id, :all_tags, tag_ids:[])
      end
  
    end
  end 