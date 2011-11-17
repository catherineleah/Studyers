class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    can :read, Lesson do |lesson|
      @user = User.find(lesson.try(:user_id))
      # If owner | if public | if friends & permission for friends.
      # THE ugliest way, but it's working 
      # @TODO: Find a better, smarter way to work that out...
      shared_ids = lesson.shares.map(&:shared_ids).to_json unless lesson.shares.map(&:shared_ids).empty?  
      lesson.try(:user_id) == user.id || shared_ids.include?(user.id.to_s) 
    end
    
    #can :manage, Lesson do |lesson|
    #  lesson.try(:user_id) == user.id 
    #end
    
    can :manage, Lesson, :user_id => user.id
    
  end
end
