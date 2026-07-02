class Collaborator < ApplicationRecord
  MEXICAN_STATES = [
    "Aguascalientes", "Baja California", "Baja California Sur", "Campeche",
    "Chiapas", "Chihuahua", "Ciudad de Mexico", "Coahuila", "Colima",
    "Durango", "Estado de Mexico", "Guanajuato", "Guerrero", "Hidalgo",
    "Jalisco", "Michoacan", "Morelos", "Nayarit", "Nuevo Leon", "Oaxaca",
    "Puebla", "Queretaro", "Quintana Roo", "San Luis Potosi", "Sinaloa",
    "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz", "Yucatan", "Zacatecas"
  ].freeze

  belongs_to :user

  encrypts :rfc
  encrypts :fiscal_address
  encrypts :curp
  encrypts :nss

  before_validation :normalize_sensitive_fields

  validates :name, :email, :rfc, :fiscal_address, :curp, :nss, :start_date,
            :contract_type, :department, :position, :daily_salary, :salary,
            :entity_key, :state, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :state, inclusion: { in: MEXICAN_STATES }

  private

  def normalize_sensitive_fields
    self.rfc = rfc.to_s.strip.upcase
    self.curp = curp.to_s.strip.upcase
    self.nss = nss.to_s.strip
  end
end
