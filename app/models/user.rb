require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  # валидации:
  VALID_EMAIL = '.+@.+\..+'
  VALID_USERNAME = '\A[a-z]+(_?[a-z0-9]+){0,2}\z'

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /#{VALID_EMAIL}/i }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: /#{VALID_USERNAME}/i }
  validates :header_style, format: { with: /\A\#[\da-fA-Z]{6}\z/ }, if: :editing_mode?

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  before_validation :downcase_username
  before_save :encrypt_password

  def downcase_username
    self.username = username.downcase
  end

  def editing_mode?
    persisted?
  end

  def encrypt_password
    if self.password.present?
      # создаём т. н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаём хэш пароля - длинная уникальная строка, из которой невозможно восстановить
      # исходный пароль
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  # служебный метод, преобразующий бинарную строку в 16-ричный формат, для убоства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # сперва находим пользователя по email

    # Cравнивается password_hash, а оригинальный пароль нигде и никогда не сохраняется!
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(
      password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST)
    )
      user
    else
      nil
    end
  end
end
