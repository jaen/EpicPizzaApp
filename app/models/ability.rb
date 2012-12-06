class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:index, :show, :order], Pizza

    if !user.admin? then
      can :order, pizza
    end

    if user.admin? then
      can :manage, :all
    end
  end
end
