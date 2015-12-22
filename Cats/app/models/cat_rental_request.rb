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
    #
    # <<-SQL
    # SELECT
    #   cat_id
    # FROM
    #   cat_rental_requests
    # WHERE
    #   end_date IN (
    #   SELECT
    #     start_date
    #   FROM
    #     cat_rental_requests
    #   WHERE
    #     start_date < end_date
    #   ) AND start_date IN (
    #     SELECT
    #       end_date
    #     FROM
    #       cat_rental_requests
    #     WHERE
    #       end_date > start_date
    #     );
    #   SQL

    #all requests for a time

  end

  def overlapping_approved_requests
    #all approved requests for a time
  end

end
