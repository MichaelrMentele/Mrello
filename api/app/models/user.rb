class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :boards, as: :owner
  has_many :lists, through: :boards
  has_many :cards, through: :lists

  has_secure_password

  def accessible_organizations_boards
    boards = []
    self.organizations.each do |organization|
      boards.push(organization.boards)
    end
    boards
  end

  def accessible_organizations_lists
    lists = []
    self.organizations.each do |organization|
      lists.push(organization.lists)
    end
    lists
  end

  def accessible_organizations_cards
    cards = []
    self.organizations.each do |organization|
      cards.push(organization.cards)
    end
    cards
  end

  def all_accessible_boards
    self.boards.joins(self.accessible_organizations_boards)
  end

  def all_accessible_lists
    self.lists.joins(self.accessible_organizations_lists)
  end

  def all_accessible_cards
    self.cards.joins(self.accessible_organizations_cards)
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