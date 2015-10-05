class Picture < ActiveRecord::Base
  belongs_to :topic
  has_attached_file :upload, styles: { medium: '300x300>', thumb: '100x100>' },
                             url: '/system/:class/:attachment/:id/:style/:hash.:extension',
                             path: ':rails_root/public/system/:class/:attachment/:id/:style/:hash.:extension',
                             hash_secret: 'get_from_rake_secret'
  validates_attachment :upload, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..1.megabytes }
  validates :upload, presence: true
end