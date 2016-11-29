class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :boards, as: :owner
  has_many :lists, through: :boards
  has_many :cards, through: :lists

  has_secure_password

  def all_accessible_boards
    all = self.boards
    self.organizations.each do |organization|
      all = all.or(organization.boards)
    end
    all
  end

  def all_accessible_lists
    all = self.lists
    self.organizations.each do |organization|
      all = all.or(organization.lists)
    end
    all
  end

  def all_accessible_cards
    all = self.cards
    self.organizations.each do |organization|
      all = all.or(organization.cards)
    end
    all
  end

  def has_access_to(resource_type, id)
    if resource_type == "Boards"
      self.all_accessible_boards.exists?(id)
    elsif resource_type == "Lists"
      self.all_accessible_lists.exists?(id)
    elsif resource_type == "Cards"
      self.all_accessible_cards.exists?(id)
    else
      false
    end        
  end
end