class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    joins(boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    joins(boats: :classifications).where(classifications: { name: 'Sailboat' }).uniq
  end

  def self.talented_seamen
    motorboaters = self.joins(boats: :classifications).where(classifications: {name: "Motorboat"}).uniq
    where("id IN (?)", self.sailors.pluck(:id) & motorboaters.pluck(:id))
  end

  def self.non_sailors
    where("id NOT IN (?)", self.sailors.pluck(:id))
  end

end
