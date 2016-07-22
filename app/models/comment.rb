class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :job
  belongs_to :parent, class_name: 'Comment'
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  validates :body, presence: true

  def parent_comment?
    !parent_id.present?
  end

  def deep_level(level=0)
    if parent
      level += 1
      parent.deep_level(level)
    else
      return level
    end
  end

end
