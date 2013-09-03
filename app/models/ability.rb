class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    can :read, :all

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

    if user.admin?
      can :manage, :all
    end

  end

end
