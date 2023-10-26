# frozen_string_literal: true
require 'debug'

require './game'
require './card'
require './user'
require './rule'

game = Game.new
card = Card.new
rule = Rule.new
player = Player.new
dealer = Dealer.new

i = 0
while i < 2 # 初回プレイヤーは二回引く
  card_info = card.card_draw
  player.draw(card_info)
  i += 1
end

# ディーラーがカードを引く
card_info = card.card_draw
dealer.dealer_first_draw(card_info)

# プレイヤーのターン
next_hand = player.player_next_hand? # 追加するかの入力
while next_hand == true # 入力にNが来るまで回り続ける
  card_info = card.card_draw
  player.draw(card_info)
  if rule.burst?(player.return_score) # ポイントが21を超えたらバーストして終了
    player.total_score
    rule.burst_message
    game.win_or_lose(player.return_score, dealer.return_score)
  end
  next_hand = player.player_next_hand?
end

# ディーラーのターン
card_info = card.card_draw
dealer.dealer_second_draw(card_info)
next_hand = dealer.cpu_next_hand? # デーラー判定式 以上でtrueを返す

while next_hand == true
  card_info = card.card_draw
  dealer.draw(card_info)
  if game.burst?(dealer.return_score)
    rule.burst_message
  end
  next_hand = dealer.cpu_next_hand?
end

# 点数表示
player.total_score_message
dealer.total_score_message

# 勝敗判定
game.win_or_lose(player.return_score, dealer.return_score)
