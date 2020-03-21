class Post < ApplicationRecord

  belongs_to :blog

  validates :title, presence: true
  validates :filename, presence: true, on: :update
  validates :commit_message, presence: true

  before_validation :set_filename
  before_validation :set_commit_message
  before_validation :modify_content

  delegate :user, to: :blog
  def set_filename
    return if filename.present?
    self.filename = Jekyll::FilenameGenerator.new(title).call
  end

  def set_commit_message
    return if commit_message.present?
    self.commit_message = Jekyll::FilenameGenerator.new(title).call
  end

  def modify_content
    return if content.blank?
    self.content = Posts::Content.new(self).call
  end
end
