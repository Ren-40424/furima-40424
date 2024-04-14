class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :read_first_name, presence: true
  validates :read_last_name,  presence: true
  validates :birth,           presence: true

  validates :password, format: {
    with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  }

  validates :first_name, :last_name, format: {
    with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  }

  validates :read_first_name, :read_last_name, format: {
    with: /\A[ァ-ヶー]+\z/
  }

  has_many :items
end
