# frozen_string_literal: true

# ユーザーに関するクラス
class User
  attr_accessor :cpu_num
  @@score_hash = {}

  def initialize(user_name)
    @own_point = 0
    @user_name = user_name
    @@score_hash[@user_name] = @own_point
  end

  # 名前毎に文章内容を変更
  def draw(card_info)
    puts "#{@user_name}の引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
  end

  # スコアを渡す
  def user_score
    @own_point
  end

  # スコアの表示
  def total_score_message
    puts "#{@user_name}の得点は#{@own_point}です。"
    add_score_hash
  end

  # ユーザーに紐づけてスコアをハッシュに格納
  def add_score_hash
    @@score_hash[@user_name] = @own_point
  end

  # 全プレイヤーのスコアが乗ったハッシュを呼び出す
  def self.private_users_score
    @@score_hash
  end

  # カードのポイントを足していく
  def sum_score(card_point)
    @own_point += card_point
  end

  # CPUの挙動
  def cpu_next_hand?
    if @own_point >= 17
      false
    elsif @own_point <= 16
      true
    end
  end
end

# プレイヤーに関するクラス
class Player < User
  # 次の手を引くかの処理
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
  def cpu_first_draw(card_info)
    puts "#{@user_name}の引いたカードは#{card_info[:suit]}の#{card_info[:num]}です。"
    sum_score(card_info[:point])
    puts "#{@user_name}の引いた２枚目のカードは分かりません。"
  end

  def cpu_second_draw(card_info)
    puts "#{@user_name}の引いた２枚目のカードは#{card_info[:suit]}の#{card_info[:num]}でした。"
    sum_score(card_info[:point])
    puts "#{@user_name}の現在の得点は#{@own_point}です。"
  end
end

# CPUクラス
class Cpu < Dealer
end
