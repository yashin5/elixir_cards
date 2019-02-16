defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling  
    a deck of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]
    cards = for value <- values, suit <- suits do
              "#{value} of #{suit}"
            end
    List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a give card

  ## Examples 

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """

    Divides a deck indo a hand and  the remainder of  the deck.
    The  'hand_size' argument  indicates how many cards should be in the hand.

  ## Examples 

      iex> deck = Cards.create_deck()
      iex>  Cards.deal(deck, 1)
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    {hand, _rest} = Enum.split(deck, hand_size)
    hand
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def create_hand(hand_size) do 
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
    |> Cards.save("my_deck")
  end

  def load_deck(filename) do
    case File.read(filename) do
    {:ok, binary} -> :erlang.binary_to_term(binary)
    {:error, _reason} -> "That file does not exist"
    end
  end

end
