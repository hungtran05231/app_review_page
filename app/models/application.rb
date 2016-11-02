class Application < ApplicationRecord
	has_many :reviews
	has_many :company_applications
	has_many :application_categories
	
	def self.app_search(search,category)
    if search
      self
        .select("applications.*,companies.company_name")
        .left_outer_joins(company_applications: :company)
        .left_outer_joins(application_categories: :category)
        .where('application_name LIKE ? OR applications.description LIKE ?', "%#{search}%", "%#{search}%")
        .where('category_name = ? OR category_name IS NULL', "%#{search}%")
    else
      self.select("applications.*,companies.company_name").left_outer_joins(company_applications: :company)
    end
  end
  
end
