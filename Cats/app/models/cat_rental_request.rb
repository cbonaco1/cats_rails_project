class CatRentalRequest < ActiveRecord::Base
  STATUS = [
    'PENDING',
    'APPROVED',
    'DENIED'
  ]

  validates :status, :inclusion => { :in => STATUS }
  validates :cat_id, :start_date, :end_date, :status, :presence=>true
  validate :overlapping_requests

  belongs_to(
    :cat,
    :class_name => 'Cat',
    :foreign_key => :cat_id,
    :primary_key => :id
  )


  def overlapping_requests
    conflicts = CatRentalRequest
      .where("start_date <= :end_date AND :start_date <= end_date", start_date: start_date, end_date: end_date)
      .where("cat_id = :cat_id", cat_id: cat_id)
      .where.not(id: id)
      #.where(":id IS NULL OR :id != id", id: id)

    unless conflicts.empty?
      errors[:base] << "Cannot add rentals which conflict"
    end

    # conflicts

  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end


  def denied?
    self.status == "DENIED"
  end

  def approved?
    self.status == "APPROVED"
  end

  def deny!
    self.status = "DENIED"
    self.save! # key point
  end

  def approve!
    transaction do
      self.status = "APPROVED"
      self.save! # key point

      #For all other overlapping requests, set to DENIED
      overlapping_pending_requests.update_all(status: "DENIED")
    end
  end

end
