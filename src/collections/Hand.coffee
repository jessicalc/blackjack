class window.Hand extends Backbone.Collection
  model: Card

  # @deck is shorthand for saying this.deck = deck parameter
  # @isDealer is shorthand for this.isDealer = isDealer param
  initialize: (array, @deck, @isDealer) -> 

  hit: ->
    @add(@deck.pop())
    if @minScore() > 21
      @trigger 'playerBusted'
    # @last()

  # TODO: Write stand
  # play's for the dealer 
  stand: ->
    @trigger 'stand'
    @first().flip()
    @add(@deck.pop()) while @minScore() <= 16
    if @minScore() > 21
      @trigger 'dealerBusted'
    else @trigger 'endGame'
    # while score is less than 16
      # dealer hits
    # if dealer busts, player wins
      # else compare scores to determine winner (dealer wins ties)


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  # this really gives the actual score for a hand, but it's referenced everywhere else as minScore
  # so we're not changing it
  # the score checks if there is an ace, and if there is, and the total score is less than 11 it adds 10
  # to account for the ace being able to be 1 or 11
  minScore: -> 
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    score += if @hasAce() and score <= 11 then 10 else 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  # minScore: -> @reduce (score, car) ->
  #   score + if card.get 'revealed' then card.get 'value' else 0
  #   if @hasAce() and score <= 11 then score += 10
  # , 0  


