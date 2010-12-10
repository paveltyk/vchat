class Chatter < ActiveRecord::Base
  named_scope :exclude_identity, lambda { |identity| { :conditions => ["chatters.identity != ?", identity] } }
  validates_uniqueness_of :identity
end
