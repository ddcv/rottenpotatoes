# Edit app/models/moviegoer.rb to look like this:
class Moviegoer < ActiveRecord::Base

  has_many :reviews
  has_many :movies, :through => :reviews

  attr_protected :uid, :provider, :name # see text for explanation

  # here's version n+1, using Setler gem for feature flag:
  scope :old_schema, where :migrated => false
  scope :new_schema, where :migrated => true
  def self.find_matching_names(string)
    if Featureflags.new_name_schema
      Moviegoer.new_schema.where('last_name LIKE :s OR first_name LIKE :s',
        :s => "%#{string}%") +
        Moviegoer.old_schema.where('name like ?', "%#{string}%")
    else # use only old schema
      Moviegoer.where('name like ?', "%#{string}%")
    end
  end
  # automatically update records to new schema when they are saved
  before_save :update_schema, :unless => lambda { |m| m.migrated? }
  def update_schema
    if name =~ /^(.*)\s+(.*)$/
      self.first_name = $1
      self.last_name = $2
    end
    self.migrated = true
  end


  def self.create_with_omniauth(auth)
    Moviegoer.create!(
      :provider => auth["provider"],
      :uid => auth["uid"],
      :name => auth["info"]["name"])
  end
end
