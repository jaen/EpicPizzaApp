class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:index, :show, :order], Pizza

    can :show, Order do |order|
      order.user == user || user.admin?
    end

    can :pay, Order do |order|
      order.user == user
    end

    if !user.admin? then
      can :order, Pizza
      can :make, Order
    end

    if user.admin? then
      can :manage, [Pizza, Ingredient]
      can [:index, :show, :deliver], Order
    end
  end
end
