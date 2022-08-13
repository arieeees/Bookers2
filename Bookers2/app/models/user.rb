class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :books, dependent: :destroy
  
  has_one_attached :profile_image
  
  def get_profile_image_id(width, height)
    unless profile_image_id.attached?
      file_path = Rails.root.join('app/assets/images/no_image_jpg')
      profile_image_id.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image_id.variant(resize_to_limit: [width, height]).processed
  end
  
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20}
  validates :introduction, length: { maximum: 50 }
  
end