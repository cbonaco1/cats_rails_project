class Cat < ActiveRecord::Base

  #inclusion validation for color
  COLORS = [
    'Black',
    'Brown',
    'White',
    'Grey',
    'Orange'
  ]

  validates :color, :inclusion => { :in => COLORS }

  #sex is either M or F
  validates :sex, :inclusion => { :in => ['M', 'F']}, :length => { :maximum => 1 }

  #presence of birth_date, name, sex
  validates :birth_date, :name, :sex, presence: true

  has_many(
    :cat_rental_requests,
    :class_name => 'CatRentalRequest',
    :foreign_key => :cat_id,
    :primary_key => :id,
    dependent: :destroy
  )

  #converts birth_date to age
  def age
    (Time.now.to_date - self.birth_date).to_i / 365
  end
end
