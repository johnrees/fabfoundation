class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # can :read, :all
    can :read, Lab
    can :read, :all

    #  do |claim|
    #   claim.lab.creator == user
    # end

    if user.persisted?
      # can :create, Claim
      # can :claim, Lab do |lab|
      #   !user.claimed_lab?(lab) and !user.manages_lab?(lab)
      # end
      can :update, Lab do |lab|
        user.labs.include? lab
      end
      can :update, User, id: user.id
      can :create, LabApplication
      # can :create, Event do |event|
      #   user.labs.any?
      # end
    else
      can :create, User
    end

    if user.admin?
      can :manage, :all
      cannot :manage, Claim
    end

  end

end
