module HabitsHelper
  def extract_youtube_id(url)
    url.match(/(?:youtube\.com\/watch\?v=|youtu.be\/)([^&]+)/)[1]
  end
end
