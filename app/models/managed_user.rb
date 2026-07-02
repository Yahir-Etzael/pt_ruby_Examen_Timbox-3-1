class ManagedUser < ApplicationRecord
  belongs_to :owner_user, class_name: "User"
  belongs_to :created_by, class_name: "User"

  encrypts :rfc

  before_validation :normalize_rfc

  validates :name, :rfc, :address, :phone, :website, presence: true

  private

  def normalize_rfc
    self.rfc = rfc.to_s.strip.upcase
  end
end
