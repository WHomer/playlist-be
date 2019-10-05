class MusixmatchService
  def initialize(query)
    @query = query
  end

  def track_search
    parse_response("track.search?q_track_artist=#{query}")
  end

  private

  attr_reader :query

  def parse_response(url, params = {})
    response = connection.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def connection
    Faraday.new('http://api.musixmatch.com/ws/1.1') do |f|
      f.params['apikey'] = ENV['MUSIXMATCH_API_KEY']
      f.params['page'] = 1
      f.params['page_size'] = 20
      f.adapter Faraday.default_adapter
    end
  end
end
