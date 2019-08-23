class SongSorter
  attr_reader :songs, :sort_param

  def initialize(songs, sort_param)
    @songs = songs
    @sort = sort_param
  end

  def self.sorter
    if sort_param == "random"
      songs.to_a.shuffle
    elsif sort_param == "reverse"
      songs.to_a.reverse
    else
      @songs
    end
  end
end
