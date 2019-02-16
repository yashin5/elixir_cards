defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  test "shuffling a deck randomiize it " do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

  test "save the deck hand" do
    deck = Cards.create_deck
    assert Cards.save(deck, "my_deck")
  end

  test "load the deck hand" do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(5)
    Cards.save("my_deck")
    deck_load = Cards.load_deck("my_deck")
    assert deck == deck_load
  end
end
