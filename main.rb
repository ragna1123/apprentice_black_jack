# frozen_string_literal: true
require 'debug'

require './game'
require './card'
require './user'

game = Game.new
card = Card.new
player = Player.new
dealer = Dealer.new

i = 0
while i < 2 # 初回プレイヤーは二回引く
  card_info = card.card_draw
  player.player_draw(card_info)
  i += 1
end

# ディーラーがカードを引く
card_info = card.card_draw
dealer.dealer_first_draw(card_info)

# プレイヤーのターン
next_hand = player.player_next_hand? # 追加するかの入力
while next_hand == true # 入力にNが来るまで回り続ける
  card_info = card.card_draw
  player.player_draw(card_info)
  if player.burst? # ポイントが21を超えたらバーストして終了
    player.player_score
    game.game_exit
  end
  next_hand = player.player_next_hand?
end

# ディーラーのターン
card_info = card.card_draw
dealer.dealer_second_draw(card_info)
next_hand = dealer.dealer_next_hand? # デーラー判定式 以上でtrueを返す

while next_hand == true
  card_info = card.card_draw
  dealer.dealer_thred_draw(card_info)
  next_hand = dealer.dealer_next_hand?
end

# 点数表示
player_score = player.player_score
dealer_score = dealer.dealer_score

# 勝敗判定
game.win_or_lose(player_score, dealer_score)
