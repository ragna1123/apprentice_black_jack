# frozen_string_literal: true

require './game'
require './card'
require './user'
require './rule'

# ゲーム関連のクラス
class Game
  # カード情報をもらう
  def initialize
    @card = Card.new
    @rule = Rule.new
    @player = Player.new
    @dealer = Dealer.new
  end

  # ゲームスタート
  def game_start
    puts 'ブラックジャックを開始します'
    play
  end

  # ゲーム進行
  def play
    2.times do
      player_add_card
    end
    dealer_add_card
    player_turn
    dealer_turn
    @player.total_score_message
    @dealer.total_score_message
    win_or_lose(@player.get_score, @dealer.get_score)
  end

  # private
  # # プレーヤーターン
  def player_add_card
    @player.draw(player_card_drow) # playerにカード情報が渡される
  end

  def player_turn
    while @player.player_next_hand? # 入力にNが来るまで回り続ける
      @player.draw(player_card_drow)
      if @rule.burst?(@player.get_score) # ポイントが21を超えたらバーストして終了
        @player.total_score_message
        @rule.burst_message
        win_or_lose(@player.get_score, @dealer.get_score)
      end
    end
  end

  # ディーラーターン
  def dealer_add_card
    @dealer.dealer_first_draw(dealer_card_drow)
  end

  def dealer_turn
    @dealer.dealer_second_draw(dealer_card_drow)
    while @dealer.cpu_next_hand? # 17以上でtrueを返してループを抜ける
      dealer_card_drow
      @dealer.draw(dealer_card_drow)
      if @rule.burst?(@dealer.get_score)
        @rule.burst_message
      end
    end
  end

  def player_card_drow
    card_info = @card.card_draw
    card_info[:point] = @rule.A_convert(card_info[:point], @player.get_score) # ポイントを見て持ち点10以下ならAを11点に変化
    card_info
  end

  def dealer_card_drow
    card_info = @card.card_draw
    card_info[:point] = @rule.A_convert(card_info[:point], @dealer.get_score) # ポイントを見て持ち点10以下ならAを11点に変化
    card_info
  end

  # 勝敗判定
  def win_or_lose(player_score, dealer_score)
    if player_score > dealer_score && player_score <= 21 && dealer_score <= 21
      puts 'あなたの勝ちです！'
    elsif dealer_score > 21 && player_score <= 21
      puts 'あなたの勝ちです'
    else
      puts 'あなたの負けです'
    end
    game_exit
  end

  # 終了処理
  def game_exit
    puts 'ブラックジャックを終了します。'
    exit
  end
end

game = Game.new
game.game_start
