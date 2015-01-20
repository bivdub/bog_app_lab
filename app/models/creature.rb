class Creature < ActiveRecord::Base

  validates :name, :uniqueness => {:case_sensitive => false}, presence: true, :format => { :with => /^[A-Za-z ]+$/, :message => "Only letters a-z  and spaces are allowed", :multiline => true }

  validates :desc, presence: true, length: { minimum: 10, maximum: 255}

  has_and_belongs_to_many :tags

end
