class Ability
  include CanCan::Ability

  def initialize(role, user, company)
    user ||= User.new

    if user.id == company.owner.id
      can :manage, Company, :owner_id => user.id
      can :manage, Site, :company_id => company.id
      can :manage, Post, :site => { :company_id => company.id }
      can :create, Post
      can :create, Membership
      can :manage, Membership, :site => { :company_id => company.id }
      can :manage, Role, :company_id => company.id
    elsif user.manager? 
      can :read, :all
    else
      can :read, Post, :permission_id => role.permission
    end

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
  end
end
