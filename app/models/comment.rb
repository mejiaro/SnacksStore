class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :review, presence: true, allow_blank: false
  def comment_user(id)
    User.find(id).username
  end

  def comment_status(status)
    if status == 'A'
      'Activated'
    else
      'Disabled'
    end
  end
end
