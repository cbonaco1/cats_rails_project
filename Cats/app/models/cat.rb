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

  #converts birth_date to age
  def age
  end
end
