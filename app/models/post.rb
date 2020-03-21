class Post < ApplicationRecord

  belongs_to :blog

  validates :title, presence: true
  validates :filename, presence: true, on: :update
  validates :commit_message, presence: true

  before_validation :set_filename
  before_validation :set_commit_message

  delegate :user, to: :blog
  def set_filename
    return if filename.present?
    self.filename = Jekyll::FilenameGenerator.new(title).call
  end

  def set_commit_message
    return if commit_message.present?
    self.commit_message = Jekyll::FilenameGenerator.new(title).call
  end
end
