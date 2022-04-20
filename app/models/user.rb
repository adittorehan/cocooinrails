class User < ApplicationRecord
    has_many :blogs, inverse_of: :user, dependent: :destroy
    accepts_nested_attributes_for :blogs, reject_if: :all_blank, allow_destroy: true 
end
