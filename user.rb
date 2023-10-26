# frozen_string_literal: true

# ユーザーに関するクラス
class User
  attr_accessor :own_point

  def initialize
    @own_point = 0
    @user_name = { 'Player' => 'あなた', 'Dealer' => 'ディーラー' }[self.class.name]
  end

  # 引いたカードを足していく
  def sum_score(card_point)
    @own_point += card_point
  end

  # スコアを渡す
  def get_score
    @own_point
  end

  # CPUの挙動
  def cpu_next_hand?
    if @own_point >= 17
      false
    elsif @own_point <= 16
      true
    end
  end

  # クラスによるメッセージの変更
  def draw(card_info)
    puts "#{@user_name}の引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
  end

  # スコアの表示の共通化
  def total_score_message
    puts "#{@user_name}の得点は#{@own_point}です。"
  end
end

# プレイヤーに関するクラス
class Player < User
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
end
