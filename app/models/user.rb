class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  has_many :blogs

  def self.create_from_provider_data(provider_data)
    user = where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.oauth_token = provider_data.credentials.token
      user.password = Devise.friendly_token[0, 20]
    end
    user.update(oauth_token: provider_data.credentials.token)
    user
  end
end
