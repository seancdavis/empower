class Identity < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :user

  # ------------------------------------------ Validations

  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  # ------------------------------------------ Class Methods

  def self.find_for_oauth(auth)
    find_or_create_by(:uid => auth.uid, :provider => auth.provider)
  end

end
