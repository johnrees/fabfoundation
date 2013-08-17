class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)

      # if user.admin?
      if user.persisted?
        can :update, Lab, creator: user
        can :update, User, id: user.id
        can :create, LabApplication
        can :create, Event do |event|
          user.labs.any?
        end
      else
        can :create, User
      end

      can :read, :all


  end
end
