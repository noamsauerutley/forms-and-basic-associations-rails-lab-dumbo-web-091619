class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes
  accepts_nested_attributes_for :notes
  
  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
  end

  def genre_name
    self.try(:genre).try(:name)
  end

  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def note_contents=(notes)
    notes.each do |content|
      if content.length > 0
        self.notes.build(content: content)
      end
    end
  end

  def note_contents
    self.notes.map do |note|
      note.content
    end
  end


end
