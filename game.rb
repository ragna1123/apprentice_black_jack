# frozen_string_literal: true

# ゲーム関連のクラス
class Game
  # カード情報をもらう
  def initialize
    puts 'ブラックジャックを開始します。'
  end

  # 勝敗判定
  # ユーザーとディーラーの得点
  def win_or_lose(own_score, dealer_score)
    if own_score > dealer_score && own_score <= 21
      puts 'あなたの勝ちです！'
    elsif dealer_score > 21
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
