# frozen_string_literal: true

class Rule
  # バースト判定
  def burst?(score)
    return unless score > 21

    true
  end

  def burst_message
    puts 'バーストしました'
  end

  # Aの点数
  def A_convert(card_point, own_point)
    return 11 if card_point == 1 && own_point <= 10

    card_point
  end
end
