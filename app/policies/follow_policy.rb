class FollowPolicy
    attr_reader :user, :follow
  
    def initialize(user, follow)
      @user = user
      @follow = follow
    end
  
    def create? 
      follow.different?(follow)
    end
end
  