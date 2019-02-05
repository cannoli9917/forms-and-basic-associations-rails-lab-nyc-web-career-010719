class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    self.try(:genre).try(:name)
  end

  def note_contents=(content)
    content.each do |c|
      if c.length > 0
        note = self.notes.build(content: c)
        note.save
      end
    end
  end

  def note_contents
    if self.notes
      self.notes.map do |note|
        note.content
      end
    end
  end

end
