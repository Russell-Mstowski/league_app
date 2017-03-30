class SummonersController < ApplicationController
  def index
  end

  def show
    summoner_name = params[:summ_name]
    summoner_info = Unirest.get("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{summoner_name}?api_key=RGAPI-24F77282-16E6-45DF-A053-24C3FAB0904F").body

    @summoner = summoner_info[summoner_name]
    summ_id = @summoner['id']

    @player_summary = Unirest.get("https://na.api.pvp.net/api/lol/na/v1.3/stats/by-summoner/#{summ_id}/summary?api_key=RGAPI-24F77282-16E6-45DF-A053-24C3FAB0904F").body

    game_type = @player_summary['playerStatSummaries']

    game_type.each do |type|
      if type['playerStatSummaryType'] == 'RankedSolo5x5'
        @ranked_info = type
      end
    end
  end
end
