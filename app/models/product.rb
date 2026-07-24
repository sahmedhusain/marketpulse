class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  belongs_to :user, optional: true
  has_many :line_items

  mount_uploader :image, ImageUploader
  serialize :image, JSON # If you use SQLite, add this line

  validates :title, :brand, :price, :model, presence: true
  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed." }
  validates :title, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed." }
  validates :price, length: { maximum: 10 }

  BRAND = %w{ Ferrari Opel Lenovo Fossil Apple Samsung Sony Dell Nike Adidas }
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam Silver Gold SpaceGray }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

  private

  # Ensures product is not destroyed if present in active carts
  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line Items present")
      throw :abort
    end
  end
end

