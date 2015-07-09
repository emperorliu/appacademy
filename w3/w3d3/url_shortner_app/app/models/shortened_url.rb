# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base

    validates :short_url, uniqueness: true
    validates :long_url, :short_url, presence: true

    belongs_to :submitter,
      class_name: "User",
      foreign_key: :submitter_id,
      primary_key: :id

    has_many :visits,
      class_name: "Visit",
      foreign_key: :shortened_url_id,
      primary_key: :id

    has_many :visitors,
      -> { distinct },
      through: :visits,
      source: :user

    has_many :taggings,
      class_name: "Tagging",
      foreign_key: :shortened_url_id,
      primary_key: :id

    has_many :tags, through: :taggings, source: :tag

  def self.random_code
    unique = false
    code = SecureRandom::urlsafe_base64(4)
    until unique
      if self.pluck(:short_url).include?(code)
        code = SecureRandom::urlsafe_base64(4)
        unique = false
      else
        unique = true
      end
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedUrl.random_code
    ShortenedUrl.create!(long_url: long_url,
                         short_url: short_url,
                         submitter_id: user.id)
    short_url
  end

  def self.get_long_url(short_url)
    ShortenedUrl.find_by(short_url: short_url).long_url
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visitors.where("visits.created_at >= ? ", 10.minutes.ago).count
  end

  def self.record_tagging!(tag, shortened_url)
    # raise "tag doesn't exist" unless TagTopic.exists?(tag_id: tag)
    Tagging.create!(tag_id: tag, shortened_url_id: shortened_url)
  end

end
