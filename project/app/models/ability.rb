# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    can :read, Item
    return unless user.present?

    alias_action :index, :show, :edit, :update, :to => :fix
    user ||= User.new # guest user (not logged in)
    user ||= current_user

    if user.usertype.zero? # admin
      can :manage, :all
    elsif user.usertype == 1 # consumer
      can :read, Item
      can :read, Category
      can :manage, Address, user_id: user.id
      can :manage, CartItem, user_id: user.id
      can :manage, Order, user_id: user.id
      can :manage, Comment, user_id: user.id
    elsif user.usertype == 2 # store
      can :read, Item
      can :manage, Item, user_id: user.id # Only can manage its own items
      can :read, Category
      can :manage, Address, user_id: user.id
      cannot :manage, CartItem
      can :fix, Order do |order|  # can deal with items which it release
        order.item.user_id == user.id
      end
      can :manage, Comment do |comment|
        comment.item.user_id == user.id
      end
      can :manage, Comment, user_id: user.id
    end



    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
