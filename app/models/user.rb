class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
 has_many :books,dependent: :destroy
  attachment :profile_image
  
  
  # ----フォロー機能アソシエーション---
  
  #フォローする側のアソシエーション
  has_many :relationships,foreign_key: :following_id
  #フォローする側がフォローしている人の情報取る
  has_many :followings, through: :relationships, source: :follower
  
  
  # フォローされる側のアソシエーション
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: :follower_id
 #フォローされている側がフォローしている情報を取る
  has_many :followers, through: :reverse_of_relationships, source: :following
  

#フォローしているかを確認する
def is_followed_by?(user)
 reverse_of_relationships.find_by(following_id: user.id).present?
end

  validates :name,
    presence: true, uniqueness: true, length: { in: 2..20 }
    # 文字数の制限を設ける→length #長さの範囲を2-20文字→in ..
    # 一意性を保つバリデーション（uniqueness: true）
  validates :introduction,
    length: { maximum: 50 }
    # 長さの下限を50文字に設定→minimum
    # presence: trueは、空欄でないことを確認している


end
