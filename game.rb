# frozen_string_literal: true

require 'debug'

require './game'
require './card'
require './user'
require './rule'
require './game_config'

# ゲーム関連のクラス
class Game
  # カード情報をもらう
  def initialize
    @card = Card.new
    @rule = Rule.new
    @player = Player.new('あなた')
    @dealer = Dealer.new('ディーラー')
    game_start
  end

  # ゲームスタート
  def game_start
    puts 'ブラックジャックを開始します'
    config
  end

  def config
    @config = Config.new
    @config.cpu_array << @dealer
    play
  end

  # ゲーム進行
  def play
    initial_deal # 初動２枚引く
    player_turn
    cpu_turn_all
    display_scores
    decide_the_winner
  end

  # 以下ゲーム進行上にあるループ処理をメソッド化
  # 初動引き
  def initial_deal
    2.times { player_add_card }
    @config.cpu_array.each { |cpu| cpu_add_card(cpu) }
  end

  # ディーラーとコンフィグで設定したCPUのターン
  def cpu_turn_all
    @config.cpu_array.each { |cpu| cpu_turn(cpu) }
  end

  # 点数表示
  def display_scores
    @player.total_score_message
    @config.cpu_array.each(&:total_score_message)
  end

  # 具体的な処理を呼び出し
  # プレーヤーターン
  def player_add_card
    @player.draw(card_drow(@player)) # playerにカード情報が渡される
  end

  def player_turn
    while @player.player_next_hand? # 入力にNが来るまで回り続ける
      @player.draw(card_drow(@player))
      next unless @rule.burst?(@player.user_score) # ポイントが21を超えたらバーストして終了

      @player.total_score_message
      @rule.burst_message
      return
    end
  end

  # CPUターン
  def cpu_add_card(player)
    player.cpu_first_draw(card_drow(player))
  end

  def cpu_turn(player)
    player.cpu_second_draw(card_drow(player))
    while player.cpu_next_hand? # 17以上でtrueを返してループを抜ける
      player.draw(card_drow(player))
      player.total_score_message
      @rule.burst_message if @rule.burst?(player.user_score)
    end
  end

  # ドロー処理
  def card_drow(player)
    card_info = @card.card_pull
    card_info[:point] = @rule.ace_convert(card_info[:point], player.user_score) # ポイントを見て持ち点10以下ならAを11点に変化
    card_info
  end

  # 勝敗判定
  def decide_the_winner
    players_score = User.private_users_score
    not_burst_player = players_score.select { |_, score| (score <= 21) }

    if not_burst_player.empty?
      p 'バーストしたため、勝者はいません。'
    else
      # 最も21に近いプレイヤーを探す
      closest_player = nil
      closest_score_diff = Float::INFINITY

      not_burst_player.each do |player, score|
        score_diff = (21 - score).abs
        if score_diff < closest_score_diff
          closest_player = player
          closest_score_diff = score_diff
        end
      end

      if closest_player
        puts "#{closest_player}が勝者です！ (#{players_score[closest_player]}点)"
      else
        puts '引き分けです。'
      end
    end
    game_exit
  end

  # 終了処理
  def game_exit
    puts 'ブラックジャックを終了します。'
    exit
  end
end

Game.new
