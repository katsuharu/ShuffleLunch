class User < ApplicationRecord

  attr_accessor :remember_token, :reset_token

  has_secure_password

  belongs_to :time_zone, optional: true

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :name,  presence: true, length: { maximum: 50 }
  validates :name, uniqueness: {
    message: Settings.user[:already_used]
  }
  validates :email, presence: true
  validates :email, uniqueness: {
    message: Settings.user[:already_used]
  }
  #validates :department_name, presence: true
  #validates :slack_id , presence: true #, uniqueness: true

  #validate :file_kind     #アップロードファイルの妥当性をfile_invalid?メソッドで検証
  #validate :over_size
  # validate :file_invalid?

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

end