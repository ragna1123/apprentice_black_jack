# frozen_string_literal: true

# ユーザーに関するクラス
class User
  def initialize
    @own_point = 0
  end

  def sum_score(card_point) # 引いたカードを足していく
    @own_point += card_point
  end

  # クラスによる名前の変更　メッセージの共通化

  # スコアの表示の共通化

  #

  def burst?
    return unless @own_point > 21

    puts 'バーストしました'
    true
  end
end

# プレイヤーに関するクラス
class Player < User
  def player_draw(card_info)
    puts "あなたの引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
  end

  # ユーザー関係のメッセージ
  def player_next_hand?
    puts "あなたの現在の得点は#{@own_point}です。カードを引きますか？（Y/N）"
    next_hand = gets.chomp
    if %w[Y y].include?(next_hand)
      true
    elsif %w[N n].include?(next_hand)
      false
    else
      player_next_hand?
    end
  end

  def player_score
    puts "あなたの得点は#{@own_point}です。"
    @own_point
  end
end

# ディーラーに関するクラス
class Dealer < User
  def dealer_first_draw(card_info)
    puts "ディーラーの引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
    puts 'ディーラーの引いた２枚目のカードは分かりません。'
  end

  def dealer_second_draw(card_info)
    puts "ディーラーの引いた２枚目のカードは#{card_info[:suit]}の#{card_info[:num]}でした。"
    sum_score(card_info[:point])
    puts "ディーラーの現在の得点は#{@own_point}です。"
  end

  def dealer_thred_draw(card_info)
    puts "ディーラーの引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
  end

  def dealer_next_hand?
    if @own_point >= 17
      false
    elsif @own_point <= 16
      true
    end
  end

  def dealer_score
    puts "ディーラーの得点は#{@own_point}です。"
    @own_point
  end
end
