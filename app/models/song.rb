class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, presence: true, if: :released
  validates :artist_name, presence: true
  validate :unique_song?
  validate :not_the_future?

  private

  def unique_song?
    self.class.all.each do |song_obj|
      if song_obj.artist_name == self.artist_name && song_obj.title == self.title && song_obj.release_year == self.release_year
        errors.add(:title, "Song already exists for artist and year")
      end
    end
  end

  def not_the_future?
    current_year = Time.now.year
    if self.release_year != nil && self.release_year > current_year
      errors.add(:release_year, "Alright Marty McFly, that's not possible")
    end
  end

end
