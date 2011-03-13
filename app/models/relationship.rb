class Relationship < ActiveRecord::Base
  belongs_to :child, :class_name => 'Node', :foreign_key => :child_id
  belongs_to :parent, :class_name => 'Node', :foreign_key => :parent_id
end
