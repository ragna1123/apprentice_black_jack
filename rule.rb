class Rule
  # バースト判定
  def burst?(score)
    return unless score > 21

    true
  end

  def burst_message
    puts 'バーストしました'
  end

  #Aの点数
  def A_convert(card_point, own_point)
    if card_point == 1 && own_point <= 10
      return 11
    else
      return card_point
    end
  end
end
