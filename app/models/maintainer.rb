class Maintainer < ApplicationRecord
	has_many_and_belongs_to :packages
end
