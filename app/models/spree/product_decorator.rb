Spree::Product.class_eval do
  
  validates :model_number, presence: true , uniqueness: true
  serialize :specs,Hash
end