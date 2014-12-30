# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  tag        :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base

  has_many(
    :taggings,
    class_name: "Taggings",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :shortened_urls,
    through: :taggings,
    source: :shortened_url
  )

  def self.tags
    TagTopic.pluck(:name)
  end
end
