class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #フォローする側からのhas_many
  has_many :relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
  #あるユーザーがフォローしている人全員を持ってくる（follower=あるユーザーにフォローされている人）
  has_many :followings, through: :relationships, source: :follower
  #フォローされる側からのhas_many。フォローする側からのアソシエーションと重複しないように、reverseとする。
  has_many :reverse_of_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  #あるユーザーをフォローしている人全員を持ってくる。(followed=あるユーザーをフォローしている人)
  has_many :followers, through: :reverse_of_relationships, source: :followed

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  has_many :group_users
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: "Group"

  def following?(user)
    followings.include?(user)
  end


  attachment :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }


end
