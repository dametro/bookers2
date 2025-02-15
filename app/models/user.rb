class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # :database_authenticatable（パスワードの正確性を検証）
  # :registerable（ユーザ登録や編集、削除）
  # :recoverable（パスワードをリセット）
  # :rememberable（ログイン情報を保存）
  # :validatable（email のフォーマットなどのバリデーション
   
  has_one_attached :image
  #デフォルト画像の指定はget_image にて
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  has_many :books, dependent: :destroy
  # has_many :books_of_user, class_name: "Book", foreign_key: "user_id", dependent: :destroy
  # できればこうしたいが、たぶん要件なので......
  
  #ご利益 次のメソッドが利用可能
  # def books
  #   Book.where(user_id: self.id)
  # end
   
  validates :name, presence: true, uniqueness: true, length: { in: 2..20 } 
  #nameは必須 かつ固有

  validates :introduction, length: { maximum: 50 }
  
  #なお、sign_up時はデフォルトで諸々必須っぽい

end
