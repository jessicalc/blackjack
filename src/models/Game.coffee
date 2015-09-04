class window.Game extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'inPlay', true
    @get('playerHand').on "playerBusted", @togglePlaying
    @get('dealerHand').on "stand", @togglePlaying

  newGame: ->
    ## starts a new game like the first time the game starts

  newRound: ->
    ## starts a new round with the same deck

  togglePlaying: =>
    @set 'inPlay', !@get 'inPlay'