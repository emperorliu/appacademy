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
    class_name: "Tagging",
    foreign_key: :tag_id,
    primary_key: :id
  )

  has_many(
    :shortened_urls,
    through: :taggings,
    source: :shortened_url
  )

  has_many :visits, through: :shortened_urls, source: :visits

  def self.tags
    TagTopic.pluck(:name)
  end

  def self.popular(n)
    TagTopic.joins(:visits).group("tag_topics.id").select("tag_topics.*").order("COUNT(DISTINCT visits.id) DESC").limit(n)
  end
end
