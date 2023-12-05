class PostsController < ApplicationController
    
    def new
        @rental = Rental.new(post_params) 
    end
    
    def create
        # @post = Post.create(post_params)
        @post = Post.new(post_params)

        @post.user_id = current_user.id

        
        #redirect_to root_path
        
    end



    private

    def post_params
        params.require(:post).permit(:description, :user_id)
    end

end
