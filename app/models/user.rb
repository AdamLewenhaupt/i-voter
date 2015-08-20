require 'phpass'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  default_scope -> {order(display_name: :asc)}

  def valid_password?(password)
    return false if encrypted_password.blank?
    return Phpass.new.check(password, encrypted_password)
  end

  def password=(new_password)
    @password = new_password
    self.encrypted_password = Phpass.new(8).hash(@password) if @password.present?
  end

  def to_param
    username
  end
end